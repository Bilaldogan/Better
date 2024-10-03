//
//  File.swift
//  
//
//  Created by Bilal on 13.09.2024.
//

import Foundation
@testable import NetworkInterface
@testable import Network

struct StubRequest: HTTPTask {
    var authorization: AuthorizationType = .none
    var route: Route = .get("/test")
    var parameters: [String : Any]? = nil
    var defaultParameters: [String : Any]? = nil
    var parameterEncoding: ParameterEncoding = .url
    var defaultHeaders: [String : String] = [:]
    var keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .convertFromSnakeCase
    var baseURL: URL = URL(string: "https://hv.com")!
    typealias Response = MockResponse
    
    struct MockResponse: Decodable, Equatable {
        let id: Int
        let title: String
        let snakeCaseField: String
    }
}
