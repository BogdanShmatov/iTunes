//
//  NetworkResponse.swift
//  Cannonball
//
//  Created by Bogdan Shmatov on 01.10.2024.
//

public enum NetworkResponse: String, Error {
    case success
    case authenticationError = "You need to be authenticated first."
    case badRequest = "Bad request"
    case outdated = "The url you requested is outdated."
    case failed = "Network request failed."
    case noData = "Response returned with no data to decode."
    case unableToDecode = "We could not decode the response."
}
