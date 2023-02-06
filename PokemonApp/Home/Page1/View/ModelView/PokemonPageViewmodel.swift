//
//  PokemonPageViewmodel.swift
//  PokemonApp
//
//  Created by Amato, Luigi on 29/01/23.
//

import Foundation


class PokemonPageViewmodel: BaseViewmodel {
    
    var alertPage: AlertPage?
    let coreDM: CoreDataManager = CoreDataManager.shared
    @Published var page:String = ""
    @Published var isPresentedAlert:Bool = false
    @Published var list: [PokemonItem] = []
    @Published var searchText = "" {
        didSet {
            print(searchText)
            searchResults(searchText: searchText) }
    }
    var listComplete: [PokemonItem] = []
    let network:Network = Network()
    let limit:Int64 = 50;
    var offset:Int64 = 0;
    var callbackIsLoading: (() -> Void)?
    var next: String = ""
    var preview: String = ""

    func onAppear(from: any BaseView) {
        Analytics.page(type: .PokemonPage)
        self.request()
    }
    
    func tapAction(actionTag: ActionTag) {}
    
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
    
    private func request() {
        var listDB = self.coreDM.getDeck()
        let isRequest = listDB.filter({$0.offset == self.offset }).count == 0
        listDB = listDB.filter({$0.offset <= self.offset })
        if !listDB.isEmpty && (!isRequest) {
            print("Recupero da DB \(listDB.count)")
            self.listComplete = listDB
            self.searchResults(searchText: self.searchText)
        }
        else {
            self.callbackIsLoading?()
            print("Nuova richiesta da serizio")
            var request:URLRequest? = nil
            guard let requestBoard = Api.board(offset: self.offset, limit: self.limit).toUrlRequest() else { return }
            request = requestBoard
            if self.next != "" {
                print("Next Page  \(self.offset) - \(self.offset/50)")
                guard let requestNewPage = Api.page(nextPage: self.next).toUrlRequest() else { return }
                request = requestNewPage
            }
            else {
                self.offset = self.offset + 50
                print("Board  \(self.offset) - \(self.offset/50)")
            }
            
            self.network.request(request: request!) { [weak self] (result:Result<PokemonResponse, NetworkError>) in
                guard let self else { return }
                switch result {
                case .success(let response):
                    self.callbackIsLoading?()
                    var index = 1 + self.listComplete.count
                    self.next = response.next ?? ""
                    self.preview = response.preview ?? ""
                    let list = response.results.map(
                       {
                           print("SAve db \(self.offset) img: \(index)")
                            let urlImage = Api.hostResources + "\(index).png"
                            let pokemon = PokemonItem.init(id:UUID(),name: $0.name, offset: self.offset,urlImage:urlImage)
                            self.coreDM.saveItem(item: pokemon)
                            pokemon.path = index
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
        let row = item.path
        print(row)
        self.page = "Page \((row/50)+1)"
        if self.list.last?.id == item.id && self.list.count >= 50 {
            print("*** Nuova richiesta **** ")
            self.offset = self.offset + 50
            self.request()
        }
    }
    
    func searchResults(searchText:String)-> Void {
        self.list = listComplete
        if searchText.isEmpty {
            
        }
        else {
            let listFilter = self.list.filter {$0.name.uppercased().contains(searchText.uppercased())}
            self.list = listFilter
        }
    }
}
