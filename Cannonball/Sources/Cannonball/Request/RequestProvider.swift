//
//  RequestProvider.swift
//  Cannonball
//
//  Created by Bogdan Shmatov on 01.10.2024.
//

public enum NetworkEnvironment {
    case debug
    case production
}

public protocol RequestProvider {
    static var environment: NetworkEnvironment { get set }
    init(environment: NetworkEnvironment)
}
