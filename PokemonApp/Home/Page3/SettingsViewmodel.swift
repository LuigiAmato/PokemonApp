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
    
    private var baseView:(any BaseView)?
    
    func onAppear(from: any BaseView) {
        self.baseView = from
    }
    
    func tapAction(actionTag:ActionTag) {
        let title = NSLocalizedString("errorAlert", comment: "")
        var msg = NSLocalizedString("msgAlert1", comment: "")
        let ok = NSLocalizedString("okAlert", comment: "")
        switch actionTag {
        case .actionDone:
            
            break
        case .actionModal:
            
            break
        case .actionPlus:
            self.alertPage = AlertPage(title: title, msg: msg, buttonOk: ok)
            self.isPresentedAlert.toggle()
            break
        case .actionOther:
            self.alertPage = AlertPage(title: title, msg: msg, buttonOk: ok)
            self.isPresentedAlert.toggle()
            break
        default:
            break
        }
    }
    
    
}


