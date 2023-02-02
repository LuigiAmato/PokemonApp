//
//  Analytics.swift
//  PokemonApp
//
//  Created by Amato, Luigi on 29/01/23.
//

import Foundation
import Firebase

enum AnalyticsPage:String {
    case LoginPage
    case MenuPage
    case PokemonPage
    case PokemonStarPage
    case PokemonDetailPage
    case PokemonDetailPageSheet
    case PokemonSettingsPage
}

enum AnalyticsAction:String {
    case LoginAction
    case TabAction
}

public class Analytics {
   
    static func page(type:AnalyticsPage){
        print("Analytics page: \(type.rawValue)")
        Firebase.Analytics.logEvent(AnalyticsEventScreenView,
                                parameters: [AnalyticsParameterScreenName: "\(type.rawValue)",
                                             AnalyticsParameterScreenClass: "\(type.rawValue)"])
       
    }
    
    static func action(type:AnalyticsAction){
        print("Analytics action: \(type.rawValue)")
        Firebase.Analytics.logEvent(type.rawValue,
                                parameters: ["Action": "\(type.rawValue)"])
    }
}
