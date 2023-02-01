//
//  PokemonRow.swift
//  PokemonApp
//
//  Created by Amato, Luigi on 29/01/23.
//

import SwiftUI

struct PokemonRow: View {
    var pokemon: PokemonItem
    var body: some View {
        HStack {
            ImageView
            .frame(width: 50, height: 50)
            .shadow(color: Color("divider"), radius: 15, x: 5, y: 10)
            Spacer()
            Text(verbatim: pokemon.name.uppercased()).font(Font.headline.weight(.bold))
            Spacer()
            Image(systemName: ((pokemon.star ?? false) ? "star.fill" : "star"))
            Spacer()
        }
    }
    
    var ImageView: some View {
        guard let url = URL(string: pokemon.urlImage) else {
            return AnyView(PokemonBallView(size: 70))
        }
        
        return AnyView(AsyncImage(url: url, content: {
            image in
            image.resizable()
                .aspectRatio(contentMode: .fill)
        }, placeholder: {
            PokemonBallView(size: 50)
        }))
    }
    
}

struct MenuRow_Previews: PreviewProvider {
    static var previews: some View {
        PokemonRow(pokemon: MenuRow_Previews.createPokemon())
    }
    
    static func createPokemon()-> PokemonItem {
        let pokemon = PokemonItem.init(id: UUID(), name: "Bulbasauro", offset: 0, urlImage: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/3.png")
        return pokemon
    }
}
