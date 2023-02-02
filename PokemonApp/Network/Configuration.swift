//
//  Configuration.swift
//  PokemonApp
//
//  Created by Amato, Luigi on 02/02/23.
//

import Foundation


class Configuration {
    
    static var isMock:Bool {
        get {
            if let isMock = ProcessInfo.processInfo.environment["MOCK"] {
                return Bool(isMock) ?? false
            }
            return false
        }
    }
    
    static var hostService:String {
        get {
            if let host = ProcessInfo.processInfo.environment["HOST"] {
                return host
            }
            return "https://pokeapi.co/api/v2/"
        }
    }
        
    static var hostResources:String {
        get {
            if let host = ProcessInfo.processInfo.environment["HOST_IMG"] {
                return host
            }
            return "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/"
        }
    }
    
}
