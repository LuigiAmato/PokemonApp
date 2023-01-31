//
//  PokemonStarPageView.swift
//  PokemonApp
//
//  Created by Amato, Luigi on 29/01/23.
//

import SwiftUI

struct PokemonStarPageView: View {
    @State public var titleTab = ""
    @State public var titleIcon = ""
    let data = (1...100).map { "Item \($0)" }

        let columns = [
            GridItem(.adaptive(minimum: 150))
        ]
    
    var body: some View {
       
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(data, id: \.self) { item in
                        
                        let pokemon = MenuRow_Previews.createPokemon()
                        VStack{
                            AsyncImage(url: URL(string: pokemon.urlImage ?? ""), content: {
                                image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fill)
                            }, placeholder: {
                                PokemonBallView(size: 70)
                            })
                            .frame(width: 80, height: 80)
                            Text("Prova")
                        }                       
                    }
                }
                .padding(.horizontal)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image(systemName: "questionmark").onTapGesture {
                        print("systemName")
                    }.foregroundColor(.blue)
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Rectangle().frame(width: 10,height: 10).cornerRadius(5).foregroundColor(Color.green)
                    
                }
            }
            .navigationTitle("Navigation")
        }
        .tabItem {
            Label(titleTab, systemImage: titleIcon)
        }
    }
    
}

struct PokemonStarPageView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonStarPageView()
    }
}
