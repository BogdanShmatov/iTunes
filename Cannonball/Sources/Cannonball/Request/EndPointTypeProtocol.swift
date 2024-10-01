//
//  EndPointTypeProtocol.swift
//  Cannonball
//
//  Created by Bogdan Shmatov on 01.10.2024.
//

import Foundation

public protocol EndPointTypeProtocol {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}

