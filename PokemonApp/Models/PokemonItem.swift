//
//  PokemonItem.swift
//  PokemonApp
//
//  Created by Amato, Luigi on 31/01/23.
//

import Foundation

class PokemonItem: Identifiable {

    public var id: UUID
    public var name: String
    public var offset: Int64
    public var urlData: Data?
    public var urlImage: String
    public var star: Bool?
    public var path:Int = 0

    init(id: UUID, name: String, offset: Int64, urlData: Data? = nil, urlImage: String,star:Bool = false) {
        self.id = id
        self.name = name
        self.offset = offset
        self.urlData = urlData
        self.urlImage = urlImage
        self.star = star
    }
}
