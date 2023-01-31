//
//  Pokemon.swift
//  Pokemon
//
//  Created by Amato, Luigi on 25/01/23.
//

import Foundation
import SwiftUI

struct PokemonResponse: Codable, Hashable {
    var count: Int
    var next: String?
    var preview: String?
    var results:[Item]
}
struct Item: Codable, Hashable {
    var name: String
    var url: String
}

