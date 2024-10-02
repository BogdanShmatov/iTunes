//
//  iTunesRequestProvider.swift
//  iTunes
//
//  Created by Bogdan Shmatov on 02.10.2024.
//

import Foundation
import Cannonball

public struct iTunesRequestProvider: RequestProvider {
    
    public static var environment: NetworkEnvironment = .production
    let router = RouterCannonball<iTunesEndPoint>()
    
    public init(environment: NetworkEnvironment) {
        iTunesRequestProvider.environment = environment
    }
    
    func search(parameters: Parameters) async throws -> Songs? {
        let (data, response) = try await router.request(iTunesEndPoint.search(parameters))
        let strategy = DefaultParseStrategy(data, response)
        let context = ParseContext(parseStrategy: strategy)
        return try await context.process()
    }
}
