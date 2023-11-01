//
//  CharacterRouter.swift
//  Demo
//
//  Created by Quan Nguyen on 30/10/2023.
//

import Alamofire
import Foundation

enum CharacterRouter: APIRouter {
    case getList(_ page: Int, _ perPage: Int)
    case getDetail(_ id: String)
    
    public var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        switch self {
        case .getList:
            return "/characters"
        case .getDetail(let id):
            return "/characters/\(id)"
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .getDetail:
            return defaultParameter
        case let .getList(page, perPage):
            var params = defaultParameter
            params["limit"] = "\(perPage)"
            params["offset"] = "\(perPage * page)"
            return params
        }
    }
}
