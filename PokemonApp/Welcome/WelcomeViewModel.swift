//
//  WelcomeViewModel.swift
//  PokemonApp
//
//  Created by Amato, Luigi on 30/01/23.
//
import Foundation
import SwiftUI

class WelcomeViewModel: BaseViewModel {
    var alertPage: AlertPage?
    @Published var isPresentedLogin = false
    @Published var isPresentedTour = false
    @Published var isPresentedAlert = false


    private var baseView:(any BaseView)?
    
    func onAppear(from: any BaseView) {
        self.baseView = from
    }
    
    func tapAction(actionTag:ActionTag) {
        let title = NSLocalizedString("errorAlert", comment: "")
        let msg = NSLocalizedString("msgAlert1", comment: "")
        let ok = NSLocalizedString("okAlert", comment: "")
        switch actionTag {
        case .actionModal: // Tutorial
            self.alertPage = AlertPage(title: title, msg: msg, buttonOk: ok)
            self.isPresentedAlert.toggle()
            break
        case .actionPlus:
            isPresentedLogin.toggle()
            break
        default:
            break
        }
    }
}
