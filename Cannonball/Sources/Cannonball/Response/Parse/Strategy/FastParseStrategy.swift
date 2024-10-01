//
//  FastParseStrategy.swift
//  Cannonball
//
//  Created by Bogdan Shmatov on 01.10.2024.
//

import Foundation

class FastParseStrategy: ParseStrategyProtocol {
    
    var data: Data?
    var response: URLResponse?
    
    required init(_ data: Data?, _ response: URLResponse?) {
        self.data = data
        self.response = response
    }
    
    func parse<T: Codable>() async throws -> T? {
        if let response = response as? HTTPURLResponse {
            let result = self.handleNetworkResponse(response, data)
            switch result {
            case .success:
                let apiResponse = NoDataResponse()
                return apiResponse as? T
            case .failure:
                throw NetworkResponse.failed
            }
        }
        throw NetworkResponse.failed
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
        case 401...500:
            guard let responseData = data else {
                return .failure(NetworkResponse.noData.rawValue)
            }
            do {
                var CriticalError: CriticalError = try JSONDecoder().decode(CriticalError.self, from: responseData)
                CriticalError.code = response.statusCode
                return .failure(CriticalError)
            } catch {
                return .failure(NetworkResponse.unableToDecode.rawValue)
            }
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        case 600: return .failure(NetworkResponse.outdated.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
}
