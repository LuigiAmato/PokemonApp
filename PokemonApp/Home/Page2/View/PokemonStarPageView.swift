//
//  PokemonStarPageView.swift
//  PokemonApp
//
//  Created by Amato, Luigi on 29/01/23.
//

import SwiftUI

struct PokemonStarPageView: BaseView {
    
    private let titleTab = NSLocalizedString("titlePage2", comment: "")
    private let titleIcon = "list.star"
    
    @StateObject fileprivate var viewModel = PokemonStarModelView()
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    func bodyFull() -> AnyView {
        
        let bodyCenter = ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(viewModel.list) { pokemon in
                    VStack{
                        AsyncImage(url: URL(string: pokemon.urlImage), content: {
                            image in
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                        }, placeholder: {
                            PokemonBallView(size: 70)
                        })
                        .frame(width: 80, height: 80)
                        Text(pokemon.name.uppercased())
                    }
                    .onLongPressGesture {
                        self.viewModel.onLongPressGesture(pokemon: pokemon)
                    }
                }
            }
            .padding(.horizontal)
        }
            .alert(isPresented: $viewModel.isPresentedAlert) {
                Alert(title: Text(viewModel.alertPage!.title), message: Text(viewModel.alertPage!.msg), dismissButton: .default(Text(viewModel.alertPage!.buttonOk)))
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Image(systemName: "questionmark").onTapGesture {
                        print("systemName")
                    }.foregroundColor(Color("divider"))
                }
            }
        
        let result = NavigationStack {
            bodyCenter.navigationTitle(self.titleTab)
        }.onAppear(){
            viewModel.onAppear(from: self)
        }.tabItem {
            Label(titleTab, systemImage: titleIcon)
        }
        
        return AnyView(result)
    }
    
    func bodyEmpty() -> AnyView {
        return AnyView(Text("Prova"))
    }
    
    func createBody()-> AnyView {
        return bodyFull()
    }
    
    var body: some View {
        createBody()
    }
    
}

struct PokemonStarPageView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonStarPageView()
    }
}
