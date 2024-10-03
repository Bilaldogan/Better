//
//  AuthorizationType.swift
//  
//
//  Created by Bilal on 13.09.2024.
//

import Foundation

/// If you want to communicate with the auth key, Bearer can be used.
/// If '`none is selected or there is no token, Authorization information header cannot be added.
public enum AuthorizationType {
    case none, bearer
    
    public func headerValue(_ token: String) -> String? {
        switch self {
        case .bearer:
            return "Bearer \(token)"
        case .none:
            return ""
        }
    }
}
