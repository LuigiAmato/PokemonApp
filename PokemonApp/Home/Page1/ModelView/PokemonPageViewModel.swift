//
//  PokemonPageViewModel.swift
//  PokemonApp
//
//  Created by Amato, Luigi on 29/01/23.
//

import Foundation


class PokemonPageViewModel: BaseViewModel {
    
    var alertPage: AlertPage?
    let coreDM: CoreDataManager = CoreDataManager()
    @Published var isPresentedAlert:Bool = false
    @Published var list: [PokemonItem] = []
    @Published var searchText = "" {
        didSet {
            print(searchText)
            searchResults(searchText: searchText) }
    }
    private var listComplete: [PokemonItem] = []
    private let network:Network = Network()
    private let limit:Int64 = 50;
    private var offset:Int64 = 0;
    
    var callbackIsLoading: (() -> Void)?

    
    func onAppear(from: any BaseView) {
        Analytics.page(type: .PokemonPage)
        self.request()
    }
    
    func tapAction(actionTag: ActionTag) {
        
    }
    
    func onLongPressGesture(pokemon:PokemonItem){
        let iStar = pokemon.star ?? false
        var msg = iStar ? "Rimosso dai preferiti" : "Aggiunto nei preferiti"
        let ok = NSLocalizedString("Ok", comment: "")
        let title = NSLocalizedString("notice", comment: "")
        pokemon.star = !iStar
        let result = coreDM.updateItem(item: pokemon)
        msg = result ? msg : NSLocalizedString("msgAlert2", comment: "")
        if result {
            request()
        }
        alertPage = AlertPage(title: title, msg: msg, buttonOk: ok)
        isPresentedAlert.toggle()
    }
    
    func getPage()-> String {
        return "Count: \(self.listComplete.count)"
        // "Page \((offset/limit)+1)"
    }
    
    private func request(){
        var listDB = self.coreDM.getDeck()
        listDB = listDB.filter({$0.offset <= self.offset }) //&& ($0.star ?? false)})
        
        if !listDB.isEmpty {
            self.listComplete = listDB
            self.searchResults(searchText: self.searchText)
        }
        else {
            
            self.callbackIsLoading?()
            guard let request = Api.board(offset: self.offset, limit: self.limit).toUrlRequest() else { return }
            self.network.request(request: request) { [weak self] (result:Result<PokemonResponse, NetworkError>) in
                guard let self else { return }
                switch result {
                case .success(let response):
                    self.callbackIsLoading?()
                    var index = 1
                    let list = response.results.map(
                        {
                            let urlImage = Api.baseUrlImage + "\(index).png"
                            let pokemon = PokemonItem.init(id:UUID(),name: $0.name, offset: self.offset,urlImage:urlImage)
                            self.coreDM.saveItem(item: pokemon)
                            index = index + 1
                            return pokemon
                        }
                    )
                    
                    self.listComplete.append(contentsOf: list)
                    self.searchResults(searchText: self.searchText)
                    break
                case .failure(let error):
                    Log.log(value: error)
                    self.callbackIsLoading?()
                    break
                }
            }
        }
    }
    
    func onItemAppear(item:PokemonItem){
        if self.list.last?.id == item.id && self.list.count >= 50 {
            self.offset = self.offset + self.limit
            self.request()
        }
    }
    
    private func searchResults(searchText:String)-> Void {
        self.list = listComplete
        if searchText.isEmpty {
            
        }
        else {
            let listFilter = self.list.filter {$0.name.uppercased().contains(searchText.uppercased())}
            self.list = listFilter
        }
    }
    
    
}
