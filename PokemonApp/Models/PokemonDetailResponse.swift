//
//  PokemonDetailResponse.swift
//  PokemonApp
//
//  Created by Amato, Luigi on 01/02/23.
//

import Foundation
import SwiftUI

struct PokemonDetailResponse: Codable, Hashable {
    var base_experience: Int
    var abilities:[AbilitiesResponse]
    var stats:[StatsResponse]
}

struct AbilitiesResponse: Codable, Hashable {
    var ability: AbilityResponse
}

struct AbilityResponse: Codable, Hashable {
    var name: String
    var url: String
}

struct StatsResponse: Codable, Hashable {
    var base_stat: Int
    var stat: StatResponse
}

struct StatResponse: Codable, Hashable {
    var name: String
}
