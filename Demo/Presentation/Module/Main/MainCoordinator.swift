//
//  MainCoordinator.swift
//  Demo
//
//  Created by Quan Nguyen on 30/10/2023.
//

import Foundation
import Combine
import SwiftUI

struct MainCoordinator: CoordinatorProtocol {

    @StateObject var viewModel: MainViewModel
    @State var activeRoute: Destination?
    @State var transition: Transition?

    @State private var isLoaded: Bool = Bool()

    let subscriber = Cancelable()

    var body: some View {
        mainView
            .route(to: $activeRoute)
            .navigation()
            .onAppear {
                self.mainView.viewModel.navigateSubject
                    .sink { route in
                        activeRoute = Destination(route: route)
                    }.store(in: subscriber)
            }
    }

    var mainView: MainView {
        return MainView(viewModel: viewModel)
    }
}

extension MainCoordinator {
    struct Destination: DestinationProtocol {

        var route: MainView.Routes

        @ViewBuilder
        var content: some View {
            switch route {
            case .detail(let item):
                DetailView(item: item)
            }
        }

        var transition: Transition {
            switch route {
            case .detail: return .push
            }
        }
    }
}
