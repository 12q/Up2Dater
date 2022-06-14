//
//  StoreResult.swift
//  up2dater
//
//  Created by 12q on 14.06.2022.
//

import Foundation

public struct StoreResult: Decodable {
    var results: [AppStoreVersion]
    
    enum CodingKeys: String, CodingKey {
        case results
    }
}
