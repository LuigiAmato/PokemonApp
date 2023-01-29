//
//  SignInViewModel.swift
//  PokemonApp
//
//  Created by Amato, Luigi on 29/01/23.
//  https://nalexn.github.io/clean-architecture-swiftui/

import Foundation
import SwiftUI


class SignInViewModel: BaseViewModel {
    
    @Published private var email: String = "" {
        didSet {}
    }
    @Published private var password: String = "" {
        didSet {}
    }
    @Published private var isPresentedReader = false
    @Published private var isPresentedMenu = false
    @Published private var isPresentedAlert = false
    
    public var titleUsername: String = "user"
    public var titlePassword: String = "pass"
    public var titlePage: String = "pass"

    func onAppear(from: any BaseView) {
        
    }

}


protocol BaseViewModel: ObservableObject {
    func onAppear(from:any BaseView)
}

protocol BaseView: View {
    func isLoading()
    func isAlert()
}
