//
//  AppStore.swift
//  up2dater
//
//  Created by 12q on 13.06.2022.
//

import Foundation

public class Checker {
    public init() {}
    
    public func hasNewVersion(completion: @escaping ((Result<Bool, CheckerError>) -> ())) {
        switch buildRequestInfo {
            case .success(let info):
                guard let appStoreURL = info.appStoreURL else {
                    completion(.failure(.appStoreURLFailure))
                    return
                }
                loadRequest(
                    buildRequest(from: appStoreURL),
                    requestInfo: info,
                    completion: completion
                )
            case .failure(let error):
                completion(.failure(error))
        }
    }
}

// MARK: - Load & Decode

private extension Checker {
    func loadRequest(_ request: URLRequest,
                     requestInfo: RequestInfo,
                     completion: @escaping ((Result<Bool, CheckerError>) -> ())) {
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(.urlRequestFailure(error)))
                return
            }
            guard let data = data else {
                completion(.failure(.invalidResponse))
                return
            }
            
            let decoder = JSONDecoder()
            do {
                let model = try decoder.decode(StoreResult.self, from: data)
                guard let info = model.results.first else {
                    completion(.failure(.noResultInfo))
                    return
                }
                let isNewer = info.isNewer(then: requestInfo.version)
                completion(.success(isNewer))
            } catch let error {
                completion(.failure(.jsonDecodeFailure(error)))
            }
        }.resume()
    }
}

// MARK: - Builders

private extension Checker {
    var buildRequestInfo: Result<RequestInfo, CheckerError> {
        guard let infoDict = Bundle.main.infoDictionary else {
            return .failure(.bundleInfoFailure)
        }
        guard let version = infoDict[C.versionKey] as? String else {
            return .failure(.bundleShortVersionFailure)
        }
        guard let identifier = infoDict[C.identifierKey] as? String else {
            return .failure(.bundleIdentifierFailure)
        }
        return .success(.init(version: version, identifier: identifier))
    }
    
    func buildRequest(from url: URL) -> URLRequest {
        URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData)
    }
}

// MARK: - Constants

private extension Checker {
    enum C {
        static let versionKey = "CFBundleShortVersionString"
        static let identifierKey = "CFBundleIdentifier"
    }
}
