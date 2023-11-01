//
//  MainViewModel.swift
//  Demo
//
//  Created by Quan Nguyen on 30/10/2023.
//

import Foundation
import Combine

protocol MainViewModelProtocol {
    func getCharactersData()
}

protocol DefaultMainViewModel: MainViewModelProtocol { }

final class MainViewModel: DefaultViewModel, DefaultMainViewModel {
    
    let title: String = "Test"
    
    private let characterUseCase: CharacterUseCase
    
    var page: Int = 0
    var perPage: Int = 15
    
    @Published var searchText: String = .empty
    @Published var charactersData: [Character] = []
    @Published private(set) var searchData: [Character] = []
    
    var navigateSubject = PassthroughSubject<MainView.Routes, Never>()
    
    init(characterUseCase: CharacterUseCase = DIContainer.shared.inject(type: CharacterUseCase.self)!) {
        self.characterUseCase = characterUseCase
    }
}

extension MainViewModel: DataFlowProtocol {
    
    typealias InputType = Load
    
    enum Load {
        case onAppear
    }
    
    func apply(_ input: Load) {
        switch input {
        case .onAppear:
            self.bindData()
            self.callFirstTime()
        }
    }
    
    private func bindData() {
        $searchText
            .debounce(for: 0.5, scheduler: WorkScheduler.mainThread)
            .removeDuplicates()
            .sink { [weak self] text in
                guard let self = self else {return}
                if text.isEmpty {
                    self.searchData = []
                } else {
                    guard self.searchData.isEmpty else {return}
                    self.searchCharacterData(text: text)
                }
            }.store(in: subscriber)
    }
    
    func didTapDetail(item: Character) {
        self.navigateSubject.send(.detail(item: item))
    }
    
    func callFirstTime() {
        guard self.charactersData.isEmpty else {return}
        self.getCharactersData()
    }
    
    func loadMore() {
        self.getCharactersData()
    }
    
    func getCharactersData() {
        self.call(argument: self.characterUseCase.getListCharacter(page: self.page, perPage: self.perPage)) { [ weak self] data in
            guard let data = data else { return }
            guard let result = data.data?.results,
                  !result.isEmpty else {
                return
            }
            self?.charactersData.append(contentsOf: result)
            self?.page += 1
        }
    }
    
    func searchCharacterData(text: String) {
        let datas = charactersData.filter { character in
            return character.name?.contains(text) ?? false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            self?.searchData = datas
        }
    }
    
    func clearSearchData() {
        searchData = []
    }
}
