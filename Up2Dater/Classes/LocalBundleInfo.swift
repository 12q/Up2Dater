//
//  LocalBundleInfo.swift
//  up2dater
//
//  Created by 12q on 14.06.2022.
//

import Foundation

struct LocalBundleInfo {
    let version: String
    let identifier: String
    
    var requestPath: String {
        C.appStorePath + identifier
    }
    
    var appStoreURL: URL? {
        URL(string: requestPath)
    }
}

// MARK: - Constants

extension LocalBundleInfo {
    enum C {
        static let appStorePath = "http://itunes.apple.com/lookup?bundleId="
    }
}
