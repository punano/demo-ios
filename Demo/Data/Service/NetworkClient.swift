//
//  NetworkClient.swift
//  Demo
//
//  Created by Quan Nguyen on 30/10/2023.
//

import Foundation
import Alamofire
import Combine

final class NetworkClient {
    static func performCombineRequest<T: Decodable>(route: APIRouter, decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<Result<T, AFError>, Never> {
        return AF.request(route).publishDecodable(type: T.self,
                                                  decoder: decoder).result()
    }
}
