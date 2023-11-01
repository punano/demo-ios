//
//  CharacterRepository.swift
//  Demo
//
//  Created by Quan Nguyen on 30/10/2023.
//

import Foundation
import Combine
import Alamofire

struct CharacterRepository: CharacterUseCase {
    func getListCharacter(page: Int, perPage: Int) -> AnyPublisher<Result<ResultWrapper, AFError>, Never> {
        return NetworkClient.performCombineRequest(route: CharacterRouter.getList(page, perPage))
    }
}
