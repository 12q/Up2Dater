//
//  CheckerError.swift
//  up2dater
//
//  Created by 12q on 14.06.2022.
//

import Foundation

public enum CheckerError: Error {
    case bundleInfoFailure
    case bundleIdentifierFailure
    case bundleShortVersionFailure
    case appStoreURLFailure
    case urlRequestFailure(Error)
    case jsonDecodeFailure(Error)
    case invalidResponse
    case noResultInfo
}

public extension CheckerError {
    var description: String {
        switch self {
            case .bundleInfoFailure:
                return "Failed to obtain various information about your bundle "
            case .bundleIdentifierFailure:
                return "Failed to obtain CFBundleIdentifier"
            case .bundleShortVersionFailure:
                return "Failed to obtain CFBundleShortVersionString"
            case .appStoreURLFailure:
                return "Failed to create URL for the app store request"
            case .urlRequestFailure(let error):
                return "Request failed due to \(error.localizedDescription)"
            case .jsonDecodeFailure(let error):
                return "JSON decode failed with error: \(error.localizedDescription). Check out your identifier indentifier (e.g.: com.yourcompany.app)"
            case .invalidResponse:
                return "Invalid response. No data to decode."
            case .noResultInfo:
                return "Invalid response. No data to decode. Check out your identifier indentifier (e.g.: com.yourcompany.app)"
        }
    }
}
