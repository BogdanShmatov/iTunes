//
//  ParseContext.swift
//  Cannonball
//
//  Created by Bogdan Shmatov on 01.10.2024.
//

final public class ParseContext {

    private var parseStrategy: ParseStrategyProtocol
    
    public init(parseStrategy: ParseStrategyProtocol) {
        self.parseStrategy = parseStrategy
    }
    
    public func process<T: Codable>() async throws -> T? {
        try await self.parseStrategy.parse()
    }
}
