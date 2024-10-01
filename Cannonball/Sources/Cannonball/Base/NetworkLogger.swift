//
//  NetworkLogger.swift
//  Cannonball
//
//  Created by Bogdan Shmatov on 01.10.2024.
//

import Foundation

final class NetworkLogger {
    
    static func log(request: URLRequest) {
        
        print("\n - - - - - - - - - - OUTGOING - - - - - - - - - - \n")
        defer { print("\n - - - - - - - - - -  END - - - - - - - - - - \n") }
        
        let urlAsString = request.url?.absoluteString ?? ""
        let urlComponents = NSURLComponents(string: urlAsString)
        
        let method = request.httpMethod != nil ? "\(request.httpMethod ?? "")" : ""
        let path = "\(urlComponents?.path ?? "")"
        let query = "\(urlComponents?.query ?? "")"
        let host = "\(urlComponents?.host ?? "")"
        
        var logOutput = """
                        \(urlAsString) \n\n
                        \(method) \(path)?\(query) HTTP/1.1 \n
                        HOST: \(host)\n
                        """
        for (key,value) in request.allHTTPHeaderFields ?? [:] {
            logOutput += "\(key): \(value) \n"
        }
        if let body = request.httpBody {
            logOutput += "\n \(NSString(data: body, encoding: String.Encoding.utf8.rawValue) ?? "")"
        }
        
        print(logOutput)
    }
    
    static func log(response: HTTPURLResponse, data: Data?) {
        print("\n - - - - - - - - - - INCOMING - - - - - - - - - - \n")
        defer { print("\n - - - - - - - - - -  END - - - - - - - - - - \n") }
        guard let responseData = data else {
            print(NetworkResponse.noData.rawValue)
            return
        }
        let statusCode = response.statusCode
        
        do {
            var jsonData: Any = "Empty response"
            if responseData.isEmpty == false {
                jsonData = try JSONSerialization.jsonObject(with: responseData, options: .mutableContainers)
            }
            let logOutput = """
                        Code \(statusCode) \n\n
                        Data: \(jsonData)\n
                        """
            
            print(logOutput)
        } catch {
            print(NetworkResponse.unableToDecode.rawValue)
            return
        }
    }
}
