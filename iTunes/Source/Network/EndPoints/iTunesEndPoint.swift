//
//  iTunesEndPoint.swift
//  iTunes
//
//  Created by Bogdan Shmatov on 02.10.2024.
//

import Foundation
import Cannonball

typealias RouterCannonball = Cannonball.Router

public enum iTunesEndPoint {
    
    case search(_ parameters: Parameters)
}

extension iTunesEndPoint {
    
    enum URLs {
        
        static let search = "/search"
    }
}

extension iTunesEndPoint: EndPointTypeProtocol {
    
    public var environmentBaseURL: String {
        return "https://itunes.apple.com"
    }
    
    public var baseURL: URL {
        guard let url = URL(string: environmentBaseURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    public var path: String {
        switch self {
        case .search: return URLs.search
        }
    }
    
    public var httpMethod: HTTPMethod {
        return .get
    }
    
    public var task: HTTPTask {
        
        switch self {
            
        case    .search(let parameters):
            
            return .requestParameters(bodyParameters: nil,
                                      bodyEncoding: .urlEncoding,
                                      urlParameters: parameters)
        }
    }
    
    public var headers: HTTPHeaders? {
        ["Content-Type" : "application/json",
         "User-Agent": "iOS/15.0"]
    }
}
