//
//  NetworkRouter.swift
//  Cannonball
//
//  Created by Bogdan Shmatov on 01.10.2024.
//

import Foundation

public protocol NetworkRouter: AnyObject {
    
    associatedtype EndPoint: EndPointTypeProtocol
    
    func request(_ route: EndPoint) async throws -> (Data, URLResponse)
    func cancel()
}
