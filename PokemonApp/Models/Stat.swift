//
//  Stat.swift
//  PokemonApp
//
//  Created by Amato, Luigi on 01/02/23.
//

import Foundation


struct Stat: Identifiable {
    let id = UUID()
    let name: String
    let base_Stat: Int
    
    init(name: String, base_Stat: Int) {
        self.name = name
        self.base_Stat = base_Stat
    }
}
