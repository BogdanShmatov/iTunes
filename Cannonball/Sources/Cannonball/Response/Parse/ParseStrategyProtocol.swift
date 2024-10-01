//
//  ParseStrategyProtocol.swift
//  Cannonball
//
//  Created by Bogdan Shmatov on 01.10.2024.
//

import Foundation

public protocol ParseStrategyProtocol {
    
    var data: Data? { get }
    var response: URLResponse? { get }
    
    func parse<T: Codable>() async throws -> T?
    
    init(_ data: Data?,
         _ response: URLResponse?)
}
