//
//  Pokemon.swift
//  Pokemon
//
//  Created by Amato, Luigi on 25/01/23.
//

import Foundation
import SwiftUI

struct Pokemons: Codable, Hashable {
    var count: Int
    var next: String?
    var preview: String?
    var results:[PokemonResponse]
}

struct PokemonResponse: Codable, Hashable {
    var name: String
    var url: String
}

struct Pokemon: Codable, Hashable, Identifiable {
    var name: String
    var url: String
    var urlImage: String
    var id: Int
}
