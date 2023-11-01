//
//  AppDependencyContainer+Injection.swift
//  Demo
//
//  Created by Quan Nguyen on 30/10/2023.
//

import Foundation

extension DIContainer {
    func registration() {
        register(type: CharacterUseCase.self, component: CharacterRepository())
    }
}
