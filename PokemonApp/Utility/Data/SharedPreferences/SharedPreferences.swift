//
//  SharedPreferences.swift
//  PokemonApp
//
//  Created by Amato, Luigi on 04/02/23.
//

import Foundation

enum TypePreferences {
    
    case setUsername(value:String)
    case setPassword(value:String)
    case getPassword
    case getUsername
    case setRemember(value:String)
    case getRemember
    
    func getValue()->String{
        switch self {
        case let .setUsername(value):
             return value
        case let .setRemember(value):
             return value
        case let .setPassword(value):
             return value
        default:
            return ""
        }
    }
    
    func getKey()->String{
        switch self {
        case .setUsername(_):
            return "username"
        case .setRemember(_):
            return "remember"
        case .setPassword(_),.getPassword:
            return "pssw"      
        case .getUsername:
            return "username"
        case .getRemember:
            return "remember"
        default:
            return ""
        }
    }
    
    
}

class SharedPreferences {
    
    func saveValue(type:TypePreferences){
        let preferences = UserDefaults.standard
        preferences.set(type.getValue(), forKey: type.getKey())
        didSave(preferences: preferences)
    }
    
    func getValue(type:TypePreferences) -> String{
        let preferences = UserDefaults.standard
        if preferences.string(forKey:type.getKey()) != nil{
            let value = preferences.string(forKey:type.getKey())
            return value!
        } else {
            return ""
        }
    }
    
    // Checking the UserDefaults is saved or not
    func didSave(preferences: UserDefaults){
        let didSave = preferences.synchronize()
        if !didSave{
            // Couldn't Save
            print("Preferences could not be saved!")
        }
    }
    
    func clearUDM(){
           UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
           UserDefaults.standard.synchronize()
       }
    
}
