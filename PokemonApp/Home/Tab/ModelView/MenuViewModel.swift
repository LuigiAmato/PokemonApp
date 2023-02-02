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
    private var view:(any BaseView)?

    func onAppear(from: any BaseView) {
        Analytics.page(type: .MenuPage)
        self.view = from
    }
    
    func tapAction(actionTag: ActionTag) {
     
        if actionTag == .actionExitPage {
            self.view?.dismissPage()
        }
    }
}
