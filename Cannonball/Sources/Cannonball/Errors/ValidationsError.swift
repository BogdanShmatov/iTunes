//
//  ValidationsError.swift
//  Cannonball
//
//  Created by Bogdan Shmatov on 01.10.2024.
//

public struct ValidationsError: Codable {
    public let field, message: String
    public let errorCode: Int?

    enum CodingKeys: String, CodingKey {
        case field, message
        case errorCode = "error_code"
    }
}
