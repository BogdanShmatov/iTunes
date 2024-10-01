//
//  HTTPTask.swift
//  Cannonball
//
//  Created by Bogdan Shmatov on 01.10.2024.
//

public enum HTTPTask {
    
    case request
    
    case requestParameters(bodyParameters: Parameters?,
                          bodyEncoding: ParameterEncoding,
                          urlParameters: Parameters?)
    
    case requestParametersAndHeaders(bodyParameters: Parameters?,
                                    bodyEncoding: ParameterEncoding,
                                    urlParameters: Parameters?,
                                    additionHeaders: HTTPHeaders?)
}
