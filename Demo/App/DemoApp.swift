//
//  DemoApp.swift
//  Demo
//
//  Created by Quan Nguyen on 30/10/2023.
//

import SwiftUI

@main
struct DemoApp: App {
    
    init() {
        DIContainer.shared.registration()
    }

    var body: some Scene {
        WindowGroup {
            MainCoordinator(viewModel: MainViewModel())
        }
    }
}
