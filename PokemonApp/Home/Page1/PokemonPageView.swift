//
//  PokemonPageView.swift
//  PokemonApp
//
//  Created by Amato, Luigi on 29/01/23.
//

import SwiftUI

struct PokemonPageView: View {
    @State public var titleTab = ""
    @State public var titleIcon = ""
    @Binding public var isLoading: Bool
    
    @StateObject fileprivate var viewModel = PokemonPageViewModel()

    var body: some View {
        NavigationStack {
                   VStack {
                       List(viewModel.list) {
                           pokemon in
                           
                           NavigationLink(destination: DetailPokemonView(pokemon: pokemon)) {
                               PokemonRow(pokemon: pokemon).padding().onAppear(){
                                   viewModel.onItemAppear(item: pokemon)
                               }
                           }                                             
                       }
                       .onAppear(){
                           print("onAppear List")
                           viewModel.callbackIsLoading = {
                               print("callbackIsLoading")
                               isLoading.toggle()
                           }
                           viewModel.onAppear()
                       }
                   }
                   .toolbar {
                       ToolbarItem(placement: .navigationBarLeading) {
                           Button("Help") {
                               print("Help tapped!")
                           }
                       }
                   }
                   .navigationTitle("Navigation")
        }
    
        .searchable(text: $viewModel.searchText, prompt: "Cerca")
        .tabItem {
            Label(titleTab, systemImage: titleIcon)
        }
    }
    
}

struct PokemonPageView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonPageView(isLoading: .constant(false))
    }
}
