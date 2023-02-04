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
            return ""
        }
    }
        
    static var hostResources:String {
        get {
            if let host = ProcessInfo.processInfo.environment["HOST_IMG"] {
                return host
            }
            return ""
        }
    }
    
    static var termsAndConditions:String {
        get {
            if let host = ProcessInfo.processInfo.environment["TERMS_AND_CONDITIONS"] {
                return host
            }
            return ""
        }
    }
    
    
    static var service:String {
        get {
            if let host = ProcessInfo.processInfo.environment["SERVICE"] {
                return host
            }
            return ""
        }
    }
    
    static var account:String {
        get {
            if let host = ProcessInfo.processInfo.environment["ACCOUNT"] {
                return host
            }
            return ""
        }
    }
}
