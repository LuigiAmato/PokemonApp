//
//  AbilityDetailResponse.swift
//  PokemonApp
//
//  Created by Amato, Luigi on 01/02/23.
//

import Foundation
import SwiftUI

struct AbilityDetailResponse: Codable, Hashable {
    var effect_entries:[EffectEntries]
}

struct EffectEntries: Codable, Hashable {
    var effect:String
    var short_effect:String
    var language:LanguageEffect
}

struct LanguageEffect: Codable, Hashable {
    var name:String
}
