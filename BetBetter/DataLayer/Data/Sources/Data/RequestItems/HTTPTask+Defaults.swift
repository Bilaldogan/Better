//
//  File.swift
//  
//
//  Created by Bilal on 4.10.2024.
//

import Foundation
import NetworkInterface
import ToolKit


extension HTTPTask {
    var baseURL: URL {
        return DependencyContainer.shared.resolve(EnvManageable.self).current.apiURL(.v4)
    }
    
    /// I am not adding more here as there is no language switching option at the moment. I have added it to be open for expansion.
    var defaultParameters: [String: Any]? {
        return ["apiKey": "bd58b8e9cae3df9aee4a8aa7ec5bc169"]
    }
    
    var authorization: AuthorizationType {
        return .none
    }
}

