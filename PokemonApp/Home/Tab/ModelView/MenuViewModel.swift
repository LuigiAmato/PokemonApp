//
//  MenuViewmodel.swift
//  PokemonApp
//
//  Created by Amato, Luigi on 31/01/23.
//

import Foundation


class MenuViewmodel: BaseViewmodel {
    
    var alertPage: AlertPage?
    @Published var isPresentedAlert: Bool = false
    @Published var isLoading: Bool = false

    func onAppear(from: any BaseView) {
        Analytics.page(type: .MenuPage)
    }
    
    func tapAction(actionTag: ActionTag) {
    }
    
}
