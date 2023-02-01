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

struct DetailPokemonView: BaseView {
    var pokemon: PokemonItem
    var size = 50.0
    var sizeBall = 220.0
    @StateObject fileprivate var viewModel = DetailPokemonViewmodel()
    
    
    init(pokemon: PokemonItem, size: Double = 180.0, sizeBall: Double = 220.0) {
        self.pokemon = pokemon
        self.size = size
        self.sizeBall = sizeBall
    }
    
    var stats:[Stat] = [Stat(name: "hp", base_Stat: 20),Stat(name: "hp", base_Stat: 20),Stat(name: "hp", base_Stat: 20),Stat(name: "hp", base_Stat: 20),Stat(name: "hp", base_Stat: 20)]
    
    var body: some View {
        ScrollView {
            ZStack{
                Color.yellow.edgesIgnoringSafeArea(.all).opacity(0.9)
                ZStack{
                    Color.red.edgesIgnoringSafeArea(.all).opacity(0.9)
                    VStack {
                        HStack {
                            Spacer()
                            ZStack{
                                Color.gray
                                Text("Exp  \(self.viewModel.base_experience ?? 0)")
                                    .frame(width: 80, alignment: .center)              .font(.system(size: 12, weight: .bold, design: .serif)).padding(.trailing,5)
                            }.frame(width:80,height: 20)
                                .cornerRadius(5)
                                .padding(.leading)
                                .padding(.top,3)
                            Spacer()
                        }
                        Spacer()
                    }
                    VStack {
                        ZStack{
                            Color.gray.edgesIgnoringSafeArea(.all).opacity(0.9)
                            Image("screen").resizable(resizingMode: Image.ResizingMode.stretch)
                            VStack {
                                Spacer()
                                AsyncImage(url: URL(string: pokemon.urlImage), content: {
                                    image in
                                    image.resizable()
                                        .aspectRatio(contentMode: .fill)
                                }, placeholder: {
                                    Image(systemName: "person.fill")
                                })
                                .shadow(color: .white, radius: 10, x: 10, y: 10)
                                .frame(width: 100, height: 100)
                            }
                        }.frame(width: UIScreen.screenWidth*0.7,height: UIScreen.screenHeight*0.25)
                            .border(.gray, width: 3)
                            .cornerRadius(5)
                            .padding(.top,25)
                        HStack {
                            Text(("Abilità: ").uppercased())
                                .padding(.leading,5)
                                .padding(.trailing,5)
                                .font(.system(size: 12, weight: .bold, design: .default)).padding(.leading,15)
                            Spacer()
                        }
                        .padding(.top,15)
                        .padding(.bottom,5)
                        HStack {
                            ForEach(self.viewModel.ability) { ability in
                                Text((ability.name).uppercased())
                                    .padding([.leading,.trailing],5)
                                    .padding([.top,.bottom],2)
                                .font(.system(size: 8, weight: .bold, design: .default))
                                .background(.white)
                                .border(.black)
                                .cornerRadius(2)
                            }
                        }
                        Spacer(minLength: 15)
                        HStack {
                            Text(("Dettagli: ").uppercased())
                                .padding(.leading,5)
                                .padding(.trailing,5)
                                .font(.system(size: 12, weight: .bold, design: .default)).padding(.leading,15)
                            Spacer()
                        }
                        ZStack{
                            VStack{
                                ForEach(self.viewModel.stats) { stat in
                                    HStack {
                                        Text("\(stat.name)".uppercased())
                                            .frame(width: 100, alignment: .trailing)              .font(.system(size: 8, weight: .bold, design: .default))
                                        Rectangle()
                                            .fill(Color.blue)
                                            .frame(width: CGFloat(stat.base_Stat), height: 5)
                                        Spacer()
                                        Text("\(stat.base_Stat)").padding(.trailing)
                                        Spacer()
                                    }
                                }
                                Spacer()
                            }
                        }
                    }
                    VStack{
                        if (pokemon.star ?? false){
                            Image(systemName: (pokemon.star ?? false) ? "star.fill" : "star").resizable().frame(width: 50,height: 50).scaledToFill()
                                .padding(.leading,UIScreen.screenWidth/2+50)
                                .padding(.top,160).foregroundColor(.yellow)
                        }
                        Spacer()
                    }
                }.frame(width: UIScreen.screenWidth*0.8,height: UIScreen.screenHeight*0.75).cornerRadius(5)
            }.frame(width: UIScreen.screenWidth*0.9,height: UIScreen.screenHeight*0.8).cornerRadius(10)
                .rotationEffect(.degrees(+1))
        }
        .scrollIndicators(.hidden)
        .tint(.blue)
        .navigationTitle(pokemon.name.uppercased())
        .onAppear(){
            Analytics.page(type: .PokemonDetailPage)
            self.viewModel.setPokemon(pokemon: self.pokemon)
            self.viewModel.onAppear(from: self)
        }
    }
    
       
    var body2: some View {
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
                        ForEach(viewModel.stats) { stat in
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
        }
        .tint(.blue)
        .navigationTitle(pokemon.name.uppercased())
        .onAppear(){
            Analytics.page(type: .PokemonDetailPage)
            self.viewModel.setPokemon(pokemon: self.pokemon)
            self.viewModel.onAppear(from: self)
        }
    }
    
    var body1: some View {
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
                    Color.white
                    VStack{
                        ForEach(self.viewModel.stats) { stat in
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
                        Spacer()
                    }
                }.frame(width: UIScreen.main.bounds.size.width*0.9,height: 300).cornerRadius(10)
                
                Text("Abilità")
                    .padding(.horizontal, 50)
                    .font(.system(size: 20, weight: .heavy, design: .default))
                ZStack{
                    Color.black.opacity(0.2)
                    VStack{
                        ForEach(self.viewModel.stats) { stat in
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
        DetailPokemonView(pokemon: MenuRow_Previews.createPokemon())
    }
}
