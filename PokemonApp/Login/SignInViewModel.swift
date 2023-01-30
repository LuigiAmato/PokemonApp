//
//  SignInViewModel.swift
//  PokemonApp
//
//  Created by Amato, Luigi on 29/01/23.
//  https://nalexn.github.io/clean-architecture-swiftui/

import Foundation
import SwiftUI


class SignInViewModel: BaseViewModel {
    var alertPage: AlertPage?
    
    @Published var email: String = "" {
        didSet {}
    }
    @Published var password: String = "" {
        didSet {}
    }
    @Published var isPresentedReader = false
    @Published var isPresentedMenu = false
    @Published var isPresentedAlert = false
    
    public var urlTermsCond: String = "https://toolboxcoworking.com/assets/Termini-e-Condizioni.pdf"
    
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
            if email.isEmpty || password.isEmpty {
                msg = NSLocalizedString("msgAlert", comment: "")
                self.alertPage = AlertPage(title: title, msg: msg, buttonOk: ok)
                self.isPresentedAlert.toggle()
            }
            else {
                self.isPresentedMenu.toggle()
            }
            break
        case .actionModal:
            self.isPresentedReader.toggle()
            break
        case .actionPlus: // registrazione
            self.alertPage = AlertPage(title: title, msg: msg, buttonOk: ok)
            self.isPresentedAlert.toggle()
            break
        case .actionOther: // shared
            self.alertPage = AlertPage(title: title, msg: msg, buttonOk: ok)
            self.isPresentedAlert.toggle()
            break
        default:
            break
        }
    }
}


