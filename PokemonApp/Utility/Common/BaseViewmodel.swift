//
//  BaseViewmodel.swift
//  PokemonApp
//
//  Created by Amato, Luigi on 30/01/23.
//

import Foundation
import Network

protocol BaseViewmodel: ObservableObject {
    var alertPage:AlertPage? { get set }
    func onAppear(from:any BaseView)
    func tapAction(actionTag:ActionTag)
}

struct AlertPage {
    var title:String
    var msg:String
    var buttonOk:String
    var buttonDelete:String?
    init(title: String, msg: String, buttonOk: String, buttonDelete: String? = nil) {
        self.title = title
        self.msg = msg
        self.buttonOk = buttonOk
        self.buttonDelete = buttonDelete
    }
}
