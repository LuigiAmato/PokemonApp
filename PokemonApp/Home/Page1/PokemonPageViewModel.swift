//
//  PokemonPageViewModel.swift
//  PokemonApp
//
//  Created by Amato, Luigi on 29/01/23.
//

import Foundation


class PokemonPageViewModel: BaseViewModel {
    
    var alertPage: AlertPage?
  
    @Published var list: [Pokemon] = []
    @Published var searchText = "" {
        didSet { searchResults(searchText: searchText) }
    }
    private var listComplete: [Pokemon] = []
    private let network:Network = Network()
    private let limit = 50;
    private var offset = 0;
    
    var callbackIsLoading: (() -> Void)?

    
    func onAppear(from: any BaseView) {
        self.request()
    }
    
    func tapAction(actionTag: ActionTag) {
        
    }
    
    private func request(){
        self.callbackIsLoading?()
            guard let request = Api.board(offset: self.offset, limit: self.limit).toUrlRequest() else { return }
            self.network.request(request: request) { [weak self] (result:Result<Pokemons, NetworkError>) in
                guard let self else { return }
                switch result {
                case .success(let response):
                    self.callbackIsLoading?()
                    var index = 1
                    let list = response.results.map(
                        {
                            let urlImage = Api.baseUrlImage + "\(index).png"
                            let pokemon = Pokemon.init(name: $0.name, url: $0.url, urlImage: urlImage, id: $0.name.hashValue)
                            index = index + 1
                            return pokemon
                        }
                    )
                    
                    self.listComplete.append(contentsOf: list)
                    self.searchResults(searchText: self.searchText)
                    break
                case .failure(let error):
                    self.callbackIsLoading?()
                    break
                }
            }
    }
    
    func onItemAppear(item:Pokemon){
        if self.list.last?.id == item.id {
            self.offset = self.offset + self.limit
            self.request()
        }
    }
    
    private func searchResults(searchText:String)-> Void {
        self.list = listComplete
        if searchText.isEmpty {
            
        }
        else {
            let listFilter = self.list.filter {$0.name.contains(searchText)}
            self.list = listFilter
        }
    }
    
    
}
