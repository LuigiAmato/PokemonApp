//
//  SignInViewmodel.swift
//  PokemonApp
//
//  Created by Amato, Luigi on 29/01/23.
//  https://nalexn.github.io/clean-architecture-swiftui/

import Foundation
import SwiftUI


class SignInViewmodel: BaseViewmodel {
    
    static var Shared:SignInViewmodel = SignInViewmodel()
    
    var alertPage: AlertPage?
    private let network:Network = Network()

    @Published var email: String = "" {
        didSet {}
    }
    @Published var password: String = "" {
        didSet {}
    }
    @Published var isPresentedReader = false
    @Published var isPresentedMenu = false
    @Published var isPresentedAlert = false
    @Published var isPresentedAlertSheet = false
    @Published var isRemembers:Bool = false
    @Published var showPassword: Bool = false
    @Published var presentSheet:Bool = false    
    @Published var createUser: String = ""
    @Published var createPassword: String = ""
    
    private let account = Configuration.account
    private let service = Configuration.service
    public var urlTermsCond: String = Configuration.termsAndConditions
    
    public var baseView:(any BaseView)?
    
    func onAppear(from: any BaseView) {
        self.baseView = from
        if SharedPreferences().getValue(type: .getRemember) == String.isOk {
            self.isRemembers.toggle()
            self.email = SharedPreferences().getValue(type: .getUsername)
            self.password = SharedPreferences().getValue(type: .getPassword)           
        }
    }
    
    private func saveCredential(){
        if self.isRemembers && !self.password.isEmpty && !self.email.isEmpty {
            //KeychainHelper.standard.save(self.password, service: service, account: account)
            SharedPreferences().saveValue(type: TypePreferences.setUsername(value: self.email))
            SharedPreferences().saveValue(type: TypePreferences.setPassword(value: self.password))
            SharedPreferences().saveValue(type: TypePreferences.setRemember(value: String.isOk))
        }
    }
    
    
    func tapAction(actionTag:ActionTag) {
        let title = NSLocalizedString("errorAlert", comment: "")
        var msg = NSLocalizedString("msgAlert1", comment: "")
        let ok = NSLocalizedString("okAlert", comment: "")
        let msgSuccess = NSLocalizedString("userCreate", comment: "")
        let titleSuccess = NSLocalizedString("compliments", comment: "")
        switch actionTag {
        case .actionRemembers:
            self.isRemembers.toggle()
            break
        case .actionPassword:
            self.showPassword.toggle()
            break
        case .actionDone:
            if email.isEmpty || password.isEmpty {
                msg = NSLocalizedString("msgAlert", comment: "")
                self.alertPage = AlertPage(title: title, msg: msg, buttonOk: ok)
                self.isPresentedAlert.toggle()
            }
            else {
                Task.init(){
                    let result = await network.doLogin(email: email, password: password)
                    if result.0 {
                        DispatchQueue.main.async {
                            self.saveCredential()
                            self.isPresentedMenu.toggle()
                        }
                    }
                    else {
                        self.alertPage = AlertPage(title: title, msg: result.1, buttonOk: ok)
                        DispatchQueue.main.async {
                            self.isPresentedAlert.toggle()
                        }
                    }
                }
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
            self.presentSheet.toggle()
            break
            
        case .actionCreateUser:
          
            Task.init() {
                let result = await self.network.createUser(email: self.createUser, password: self.createPassword)
                if result.0 {
                    DispatchQueue.main.async {
                        self.alertPage = AlertPage(title: titleSuccess, msg: msgSuccess, buttonOk: ok,buttonDelete: "Annulla")
                        DispatchQueue.main.async {
                            self.isPresentedAlertSheet.toggle()
                        }
                    }
                }
                else {
                    self.alertPage = AlertPage(title: title, msg: result.1, buttonOk: ok)
                    DispatchQueue.main.async {
                        self.isPresentedAlertSheet.toggle()
                    }
                }
            }
            break
        default:
            break
        }
    }
}


