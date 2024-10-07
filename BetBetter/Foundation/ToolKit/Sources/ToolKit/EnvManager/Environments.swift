//
//  File.swift
//  
//
//  Created by Bilal on 13.09.2024.
//

import Foundation

/// An enum representing different environments (development and production) for API calls.
/// The `prod` case is intentionally left unimplemented for future expansion.
/// This enum is designed to be extended for selecting platforms and base API endpoints within the application.
public enum Environments {
    case dev
    case prod
    
    public func apiURL(_ version: ApiVersion = .v4) -> URL {
        return switch self {
        case .dev:
            URL(string: "https://api.the-odds-api.com/" + version.rawValue)!
        case .prod:
            fatalError("Not implemented")
        }
    }
    
    
    public enum ApiVersion: String {
        case v4 = "v4"
    }
}
