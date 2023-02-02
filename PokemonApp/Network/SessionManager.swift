//
//  SessionManager.swift
//  PokemonApp
//
//  Created by Amato, Luigi on 02/02/23.
//

import Foundation

class SessionManager {
    static public let Shared:SessionManager = SessionManager()
    private init(){}
    public var user:String = ""
    public var idUser:String = ""
}
