//
//  AppStoreInfo.swift
//  up2dater
//
//  Created by 12q on 14.06.2022.
//

import Foundation

public struct AppStoreVersion: Decodable {
    var version: String
    var releaseNotes: String
    var trackId: Int
    
    enum CodingKeys: String, CodingKey {
        case version
        case releaseNotes
        case trackId
    }
}

extension AppStoreVersion {
    func isNewer(then bundleVersion: String) -> Bool {
        switch version.compare(bundleVersion, options: .numeric) {
            case .orderedSame,
                 .orderedAscending:
                return false
            case .orderedDescending:
                return true
        }
    }
}
