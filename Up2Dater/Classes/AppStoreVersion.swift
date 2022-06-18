//
//  AppStoreVersion.swift
//  Pods-Up2Dater_Tests
//
//  Created by 12q on 14.06.2022.
//

import Foundation
/**
 AppStoreVersion model

 Calling this method increments the `numberOfTrips`
 and increases `distanceTraveled` by the value of `meters`.

 - Parameter version: The current AppStore's version
 - Parameter releaseNotes: The `releaseNotes` for this version
 - Parameter appStorePath: The `path` is generated path for opening in the AppStore app
 */
public struct AppStoreVersion {
    let appId: String
    public let version: String
    public let releaseNotes: String
    public let appStorePath: String
    
    init(appId: String, version: String, releaseNotes: String = "") {
        self.appId = appId
        self.version = version
        self.releaseNotes = releaseNotes
        self.appStorePath = "itms-apps://apple.com/app/id\(appId)"
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
