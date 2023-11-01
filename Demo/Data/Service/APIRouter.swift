//
//  APIRouter+Protocol.swift
//  Demo
//
//  Created by Quan Nguyen on 30/10/2023.
//

import Foundation
import Alamofire

enum APIVersion: String {
    case none
    case v1, v2, v3
    var desc: String {
        switch self {
        case .none:
            return .empty
        case .v1:
            return "/v1/public"
        case .v2:
            return "/v2"
        case .v3:
            return "/v3"
        }
    }
}

protocol APIRouter: URLRequestConvertible {
    var method: HTTPMethod { get }
    var baseURL: String { get }
    var path: String { get }
    var parameters: Parameters? { get }
    var version: APIVersion { get }
    
    func asURLRequest() throws -> URLRequest
}

extension APIRouter {
    var version: APIVersion {
        return .v1
    }
    var baseURL: String {
        return Constants.Domain.baseUrl
    }
    
    var parameters: Parameters? {
        return defaultParameter
    }
    
    func asURLRequest() throws -> URLRequest {
        let urlWithPathValue = baseURL + version.desc + path
        var url = try urlWithPathValue.asURL()
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = method.rawValue
        if let parameters = parameters {
            var urlComponents = URLComponents(string: urlWithPathValue)!
            urlComponents.queryItems = []
            
            _ = parameters.map { (key, value) in
                let item = URLQueryItem(name: key, value: value as? String)
                urlComponents.queryItems?.append(item)
            }
            
            url = urlComponents.url!
            urlRequest.url = url
        }
        return urlRequest
    }
    
    var defaultParameter: Parameters {
        return [
            "ts": "1",
            "apikey": Constants.Credentials.apiKey,
            "hash": Constants.Credentials.keyHash
        ]
    }
}
