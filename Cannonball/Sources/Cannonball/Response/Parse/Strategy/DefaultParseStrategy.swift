//
//  DefaultParseStrategy.swift
//  Cannonball
//
//  Created by Bogdan Shmatov on 01.10.2024.
//

import Foundation

public enum Result<String>{
    case success
    case failure(String)
}

public class DefaultParseStrategy: ParseStrategyProtocol {
    
    public var data: Data?
    public var response: URLResponse?
    public var error: Error?
    
    required public init(_ data: Data?, _ response: URLResponse?) {
        self.data = data
        self.response = response
    }
    
    public func parse<T: Codable>() async throws -> T? {
        
        if let response = response as? HTTPURLResponse {
            let result = self.handleNetworkResponse(response, data)
            switch result {
            case .success:
                
                guard let responseData = data else {
                    throw NetworkResponse.noData
                }
                
                return try JSONDecoder().decode(T.self, from: responseData)
                
            case .failure:
                throw NetworkResponse.failed
            }
        }
        throw NetworkResponse.unableToDecode
    }
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse, _ data: Data?) -> Result<Any> {
        NetworkLogger.log(response: response, data: data)
        switch response.statusCode {
        case 200...299: return .success
        case 422:
            guard let responseData = data else {
                return .failure(NetworkResponse.noData.rawValue)
            }
            do {
                let validationErrors: [ValidationsError] = try JSONDecoder().decode(Array<ValidationsError>.self, from: responseData)
                return .failure(validationErrors)
            } catch {
                return .failure(NetworkResponse.unableToDecode.rawValue)
            }
        case 400...500:
            guard let responseData = data else {
                return .failure(NetworkResponse.noData.rawValue)
            }
            do {
                var CriticalError: CriticalError = try JSONDecoder().decode(CriticalError.self, from: responseData)
                
                if response.statusCode != 400 {
                    CriticalError.code = response.statusCode
                }
                
                return .failure(CriticalError)
            } catch {
                return .failure(NetworkResponse.unableToDecode.rawValue)
            }
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
    
    fileprivate func handleDecodingError(_ error: DecodingError) {
        print("🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥DecodingError LOG START🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥")
        switch error {
        case .typeMismatch(let key, let value):
            
            print("TypeMismatch: \(key) \n\n")
            print("JSONKey: \(value.codingPath[0]) \n\n")
            print("CodingKeys: \(value.codingPath[1]) \n\n")
            print("DebugDescription: \(value.debugDescription) \n\n")
            print("ERROR: \(error.localizedDescription)")
            print("Value: \(value) \n\n")
            
        case .valueNotFound(let key, let value):
            
            print("ValueNotFound: \(key) \n\n")
            print("Value: \(value) \n\n")
            print("ERROR: \(error.localizedDescription) \n\n")
            
        case .keyNotFound(let key, let value):
            
            print("KeyNotFound: \(key) \n\n")
            print("Value: \(value) \n\n")
            print("ERROR: \(error.localizedDescription) \n\n")
            
        case .dataCorrupted(let key):
            
            print("DataCorrupted: \(key), \n\n")
            print("ERROR: \(error.localizedDescription)\nn")
            
        default:
            print("ERROR: \(error.localizedDescription)")
        }
        print("🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥DecodingError LOG END🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥")
    }
}
