//
//  CharacterUseCase.swift
//  Demo
//
//  Created by Quan Nguyen on 30/10/2023.
//

import Foundation
import Alamofire
import Combine

protocol CharacterUseCase {
    func getListCharacter(page: Int, perPage: Int) ->AnyPublisher<Result<ResultWrapper, AFError>, Never>
}
