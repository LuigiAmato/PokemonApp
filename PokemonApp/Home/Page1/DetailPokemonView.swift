//
//  DetailPokemonView.swift
//  PokemonApp
//
//  Created by Amato, Luigi on 29/01/23.
//

import SwiftUI
import Charts

struct Stat: Identifiable {
    let id = UUID()
    let name: String
    let base_Stat: Int
    
    init(name: String, base_Stat: Int) {
        self.name = name
        self.base_Stat = base_Stat
    }
}

struct DetailPokemonView: View {
    var pokemon: Pokemon
    var size = 180.0
    var sizeBall = 220.0
    
    let stats: [Stat] = [
        Stat(name: "HP", base_Stat: 45),
        Stat(name: "Attack", base_Stat: 49),
        Stat(name: "Defence", base_Stat: 49),
        Stat(name: "special attack", base_Stat: 65),
        Stat(name: "special defense", base_Stat: 65),
        Stat(name: "special ", base_Stat: 90),
        Stat(name: "special ", base_Stat: 92)
    ]
    
    // https://www.kodeco.com/6398124-swiftui-tutorial-for-ios-creating-charts
    
    var body: some View {
        ScrollView {
            VStack() {
                ZStack {
                    PokemonBallView(size: sizeBall)
                    VStack {
                        AsyncImage(url: URL(string: pokemon.urlImage), content: {
                            image in
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                        }, placeholder: {
                            Image(systemName: "person.fill")
                        })
                        .frame(width: size, height: size)
                    }
                }.frame(width: 300,height: 300)
               
                    Text("In dettaglio")
                        .padding(.horizontal, 50)
                        .font(.system(size: 20, weight: .heavy, design: .default))
                ZStack{
                    Color.black.opacity(0.2)
                    VStack{
                    ForEach(stats) { stat in
                            HStack {
                                // 2
                                Text("\(stat.name)")
                                    .frame(width: 100, alignment: .trailing)
                                // 3
                                Rectangle()
                                    .fill(Color.blue)
                                    .frame(width: CGFloat(stat.base_Stat), height: 20)
                                // 4
                                Spacer()
                                Text("\(stat.base_Stat)").padding(.trailing)
                            }
                        }
                    }
                }.frame(width: UIScreen.main.bounds.size.width*0.9,height: 300).cornerRadius(10)
                
                Text("Abilità")
                    .padding(.horizontal, 50)
                    .font(.system(size: 20, weight: .heavy, design: .default))
                ZStack{
                    Color.black.opacity(0.2)
                    VStack{
                    ForEach(stats) { stat in
                            HStack {
                                // 2
                                Text("\(stat.name)")
                                    .frame(width: 100, alignment: .trailing)
                                // 3
                                Rectangle()
                                    .fill(Color.blue)
                                    .frame(width: CGFloat(stat.base_Stat), height: 20)
                                // 4
                                Spacer()
                                Text("\(stat.base_Stat)").padding(.trailing)
                            }
                        }
                    }
                }.frame(width: UIScreen.main.bounds.size.width*0.9,height: 300).cornerRadius(10)
                
            }
        }
        .scrollIndicators(.hidden)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Image(systemName: "star.fill").onTapGesture {
                    print("prova")
                }
            }
        }.tint(.blue)
        .navigationTitle(pokemon.name.uppercased())
    }
    
}

struct DetailPokemonView_Previews: PreviewProvider {
    static var previews: some View {
        let pokemonTmp = Pokemon(name: "Bulbasaur", url: "", urlImage: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/3.png", id: 0)
        DetailPokemonView(pokemon: pokemonTmp)
    }
}
