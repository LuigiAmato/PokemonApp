//
//  SettingsViewmodel.swift
//  PokemonApp
//
//  Created by Amato, Luigi on 02/02/23.
//

import Foundation
import SwiftUI


class SettingsViewmodel: BaseViewmodel {
    var alertPage: AlertPage?
    @Published var isPresentedAlert = false
    var baseView:(any BaseView)?
    @Published var list:[String] = ["Domandi frequenti","Chatbot","Recensione App","Contattaci","Info App"]
    
    func onAppear(from: any BaseView) {
        self.baseView = from
    }
    
    func tapAction(actionTag:ActionTag) {
        let title = NSLocalizedString("errorAlert", comment: "")
        let msg = NSLocalizedString("msgAlert1", comment: "")
        let ok = NSLocalizedString("okAlert", comment: "")
        self.alertPage = AlertPage(title: title, msg: msg, buttonOk: ok)
        self.isPresentedAlert.toggle()
    }
}


