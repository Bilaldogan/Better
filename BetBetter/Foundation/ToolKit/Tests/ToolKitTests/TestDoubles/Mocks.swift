//
//  File.swift
//  
//
//  Created by Bilal on 13.09.2024.
//

import XCTest
@testable import ToolKit
import Foundation

protocol MockServiceProtocol {
    func doSomething() -> String
}

class MockService: MockServiceProtocol {
    func doSomething() -> String {
        return "MockService did something"
    }
}

class AnotherMockService: MockServiceProtocol {
    func doSomething() -> String {
        return "AnotherMockService did something"
    }
}
