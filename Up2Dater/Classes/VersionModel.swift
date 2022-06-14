//
//  VersionModel.swift
//  Pods-Up2Dater_Tests
//
//  Created by Slava on 14.06.2022.
//

import Foundation

public struct VersionModel {
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
