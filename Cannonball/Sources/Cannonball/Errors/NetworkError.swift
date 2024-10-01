//
//  NetworkError.swift
//  Cannonball
//
//  Created by Bogdan Shmatov on 01.10.2024.
//

public enum NetworkError: String, Error {
    case parmetersNill = "🔥 Parameters were nil error. 🔥"
    case encodingFailed = "🔥 Parameter encoding failed. 🔥"
    case missingURL = "🔥 URL is nil. 🔥"
}
