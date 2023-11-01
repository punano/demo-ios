//
//  BaseViewModel.swift
//  Demo
//
//  Created by Quan Nguyen on 30/10/2023.
//

import Foundation
import Combine
import Alamofire

enum ViewModelStatus: Equatable {
    case loadStart
    case dismissAlert
    case emptyStateHandler(title: String, isShow: Bool)
}

protocol BaseViewModelEventSource: AnyObject {
    var loadingState: CurrentValueSubject<ViewModelStatus, Never> { get }
}

protocol ViewModelService: AnyObject {
    func call<ReturnType>(argument: AnyPublisher<Result<ReturnType, AFError>,
                          Never>,
                          callback: @escaping (_ data: ReturnType?) -> Void)
}

typealias BaseViewModel = BaseViewModelEventSource & ViewModelService

open class DefaultViewModel: BaseViewModel, ObservableObject {
    var loadingState = CurrentValueSubject<ViewModelStatus, Never>(.dismissAlert)
    let subscriber = Cancelable()
    
    func call<ReturnType>(argument: AnyPublisher<Result<ReturnType, Alamofire.AFError>, Never>,
                          callback: @escaping (ReturnType?) -> Void) {
        self.loadingState.send(.loadStart)
        
        let resultValueHandler: (Result<ReturnType, AFError>) -> Void = { [weak self] result in
            switch result {
            case .failure(let error):
                print("Error: ---- \(error)")
                self?.loadingState.send(.dismissAlert)
                self?.loadingState.send(.emptyStateHandler(title: "\(error)", isShow: true))
            case .success(let data):
                self?.loadingState.send(.dismissAlert)
                callback(data)
            }
        }

        argument
            .subscribe(on: WorkScheduler.backgroundWorkScheduler)
            .receive(on: WorkScheduler.mainScheduler)
            .sink(receiveCompletion: {_ in }, receiveValue: resultValueHandler)
            .store(in: subscriber)
    }
}
