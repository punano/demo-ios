//
//  MainView.swift
//  Demo
//
//  Created by Quan Nguyen on 30/10/2023.
//

import SwiftUI
import Combine

struct MainView: Coordinatable {
    
    typealias Route = Routes
    
    @StateObject var viewModel: MainViewModel = MainViewModel()
    
    enum Constant {
        static let searchHeight: CGFloat = 55
        static let topPadding: CGFloat = 5
        static let cornerRadius: CGFloat = 10
    }
    
    @State private var shouldShowDropdown = false
    @State private var isLoading: Bool = false
    @State private var presentAlert = true
    @State private var alertMesagee: String = ""
    
    let subscriber = Cancelable()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.clear
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    HStack {
                        Image(uiImage: UIImage(named: "logo_marvel") ?? UIImage())
                            .resizable()
                            .frame(width: 100, height: 35)
                        Text("Heroes")
                            .font(Font.system(size: 30, weight: .bold, design: .monospaced))
                        Spacer()
                    }
                    SearchBar(isLoading: isLoading,
                              text: $viewModel.searchText,
                              isEditing: $shouldShowDropdown,
                    onClearSearchData: {
                        self.viewModel.clearSearchData()
                    })
                    .padding(.horizontal, 5)
                    .overlay(
                        VStack {
                            if self.shouldShowDropdown {
                                Spacer(minLength: Constant.searchHeight + 10)
                                Dropdown(characters: viewModel.searchData,
                                         onCharacterSelected: { character in
                                    self.viewModel.didTapDetail(item: character)
                                })
                                .padding(.horizontal)
                            }
                        }, alignment: .topLeading
                    )
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.black.opacity(0.1))
                    )
                    .zIndex(1)
                    .padding(.top, Constant.topPadding)
                    characterList()
                    if !presentAlert{
                        self.showAlert("Error", alertMesagee)
                    }
                }
                .padding(.leading, 16)
                .padding(.trailing, 16)
            }
            .onViewDidLoad {
                self.viewModel.apply(.onAppear)
            }
        }
        .onAppear(perform: handleState)
    }
    
    func characterList() -> some View {
        return ScrollView {
            LazyVStack{
                ForEach(viewModel.charactersData, id: \.id) { item  in
                    CharacterCellView(item: item)
                        .onTapGesture {
                            self.viewModel.didTapDetail(item: item)
                        }
                }
                if isLoading {
                    ZStack {
                        RoundedRectangle(cornerRadius: Constant.cornerRadius)
                            .foregroundColor(Color.white.opacity(0.8))
                            .frame(width: 40.0, height: 40.0)
                        ActivityIndicator(style: .medium, animate: .constant(true))
                    }
                } else {
                    Color.clear
                        .onAppear {
                            if !isLoading, !self.viewModel.charactersData.isEmpty {
                                self.viewModel.loadMore()
                            }
                        }
                }
            }
        }
    }
}

extension MainView {
    enum Routes: Routing {
        static func == (lhs: MainView.Routes, rhs: MainView.Routes) -> Bool {
            return true
        }
        
        case detail(item: Character)
    }
}

extension MainView {
    private func handleState() {
        self.viewModel.loadingState
            .receive(on: WorkScheduler.mainThread)
            .sink { state in
                switch state {
                case .loadStart:
                    self.isLoading = true
                case .dismissAlert:
                    self.isLoading = false
                case .emptyStateHandler(let message, _):
                    self.isLoading = false
                    self.presentAlert = false
                    self.alertMesagee = message
                }
            }.store(in: subscriber)
    }
}

extension MainView {
    func showAlert(_ title: String, _ message: String) -> some View {
        CustomAlertView(title: title, message: message, primaryButtonLabel: "Retry", primaryButtonAction: {
            self.presentAlert = true
            self.viewModel.callFirstTime()
        })
        .previewLayout(.sizeThatFits)
        .padding()
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(viewModel: MainViewModel())
    }
}
