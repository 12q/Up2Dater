//
//  LocalBundleInfoBuilder.swift
//  Pods
//
//  Created by 12q on 18.06.2022.
//

import Foundation

struct LocalBundleInfoBuilder {
    static func build() -> Result<LocalBundleInfo, AppStoreVersionError> {
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
}

extension LocalBundleInfoBuilder {
    enum C {
        static let versionKey = "CFBundleShortVersionString"
        static let identifierKey = "CFBundleIdentifier"
    }
}
