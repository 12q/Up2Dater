//
//  AppStoreVersionManager.swift
//  up2dater
//
//  Created by 12q on 13.06.2022.
//

import Combine
import Foundation

public typealias VersionCompletion = (Result<AppStoreVersion?, AppStoreVersionError>) -> ()

@available(iOS 13, *)
public class AppStoreVersionManager {
    let defaults = UserDefaults.standard

    var publisher: AnyCancellable?

    public init() {}
    
    /**
        Set the Version that you dont want to track
     
     - Parameters:
     - version: String value
     */
    public func setSkipVersion(_ version: String) {
        defaults.string(forKey: C.skipVersionKey)
    }

    /**
     Fetches the latest AppStore version available for download.
     
     - Parameters:
     - completion: Result<AppStoreVersion?, AppStoreVersionError>
     Completion result will be on the mean tread
     */
    public func checkNewVersion(with completion: @escaping VersionCompletion) {
        let localBundleInfo = LocalBundleInfoBuilder.build()
        switch localBundleInfo {
            case .success(let info):
                guard let appStoreURL = info.appStoreURL else {
                    completion(.failure(.appStoreURLFailure))
                    return
                }
                let request = URLRequest(
                    url: appStoreURL,
                    cachePolicy: .reloadIgnoringLocalCacheData
                )
                loadRequest(
                    request: request,
                    localBundleInfo: info,
                    with: completion
                )
            case .failure(let error):
                completion(.failure(error))
        }
    }
    
    /**
     Fetches the latest AppStore version available for download.
     
     - Parameters:
     - deadline: DispatchTime, after what the the block will be performed
     - completion: Result<AppStoreVersion?, AppStoreVersionError>
     - default `DispatchTime` is 3.0 seconds
    Completion result will be on the mean tread
     */
    public func checkNewVersionAfter(deadline: DispatchTime = .now() + 3.0,
                           completion: @escaping  VersionCompletion) {
        let localBundleInfo = LocalBundleInfoBuilder.build()
        DispatchQueue.global().asyncAfter(deadline: deadline) { [weak self] in
            switch localBundleInfo {
                case .success(let info):
                    guard let appStoreURL = info.appStoreURL else {
                        completion(.failure(.appStoreURLFailure))
                        return
                    }
                    let request = URLRequest(
                        url: appStoreURL,
                        cachePolicy: .reloadIgnoringLocalCacheData
                    )
                    self?.loadRequest(
                        request: request,
                        localBundleInfo: info,
                        with: completion
                    )
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
}

// MARK: - Loading Data

@available(iOS 13, *)
extension AppStoreVersionManager {
    func loadRequest(request: URLRequest,
                     localBundleInfo: LocalBundleInfo,
                     with completion: @escaping VersionCompletion) {
        let skipVersion = defaults.string(forKey: C.skipVersionKey)
        
        publisher = loadProduct(with: request)
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: {
                switch $0 {
                    case .finished: break
                    case .failure(let error):
                        completion(.failure(.generic(error)))
                }
            }, receiveValue: {
                guard let model = $0.versionModel else {
                    completion(.failure(.noResultInfo))
                    return
                }
                let isNewer = model.isNewer(then: localBundleInfo.version)
                guard isNewer else {
                    completion(.success(nil))
                    return
                }
                guard skipVersion != model.version else {
                    completion(.success(nil))
                    return
                }
                completion(.success(model))
            })
    }
    
    func loadProduct(with request: URLRequest) -> AnyPublisher<AppStoreVersionResponse, Error> {
        URLSession.shared
            .dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: AppStoreVersionResponse.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    enum C {
        static let skipVersionKey = "appStoreSkipVersionKey"
    }
}
