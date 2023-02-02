//
//  PokemonStarViewmodel.swift
//  PokemonApp
//
//  Created by Amato, Luigi on 31/01/23.
//

import Foundation


class PokemonStarViewmodel: BaseViewmodel {
    
    var alertPage: AlertPage?
    let coreDM: CoreDataManager = CoreDataManager.shared
    @Published var list: [PokemonItem] = []
    @Published var isPresentedAlert: Bool = false

    func onAppear(from: any BaseView) {
        Analytics.page(type: .PokemonSettingsPage)
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
    
    private func request(){
        let listDB = self.coreDM.getDeck()
        self.list = listDB.filter({($0.star ?? false)})
    }
    
}
