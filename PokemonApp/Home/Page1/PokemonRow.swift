//
//  PokemonRow.swift
//  PokemonApp
//
//  Created by Amato, Luigi on 29/01/23.
//

import SwiftUI

struct PokemonRow: View {
    var pokemon: Pokemon
    var body: some View {
        HStack {
            AsyncImage(url: URL(string: pokemon.urlImage), content: {
                image in
                image.resizable()
                    .aspectRatio(contentMode: .fill)
            }, placeholder: {
                Image(systemName: "person.fill")
            })
            .frame(width: 50, height: 50) .cornerRadius(25)
            .overlay(RoundedRectangle(cornerRadius: 25)
                .stroke(Color.blue, lineWidth: 1))
            Text(verbatim: pokemon.name.uppercased()).font(Font.headline.weight(.bold))
            Spacer()
            Button {
                print("Edit button was tapped")
            } label: {
                Image(systemName: "star.fill")
            }
        }
    }
}

struct MenuRow_Previews: PreviewProvider {
    static var previews: some View {
        PokemonRow(pokemon: Pokemon(name: "Prova", url: "", urlImage: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/3.png", id: 0))
    }
}
