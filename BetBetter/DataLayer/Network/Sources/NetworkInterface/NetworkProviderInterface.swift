//
//  File.swift
//  
//
//  Created by Bilal on 13.09.2024.
//

import Foundation

public protocol NetworkProviderInterface {
    func request<T: HTTPTask>(_ task: T) async throws -> T.Response
}
