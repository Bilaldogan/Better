//
//  File.swift
//  
//
//  Created by Bilal on 13.09.2024.
//

import Foundation

// This tool is designed so that the location where the token is stored can be accessed by the network at any time.
// This is an optional tool, the network tool can work without it.
public protocol TokenProvider {
    func accessToken() -> String?
}
