//
//  PokemonPageView.swift
//  PokemonApp
//
//  Created by Amato, Luigi on 29/01/23.
//

import SwiftUI

struct PokemonPageView: BaseView {
    
    private let titleTab = NSLocalizedString("titlePage1", comment: "")
    private let titleIcon = "list.number"
    @Binding public var isLoading: Bool
    @StateObject fileprivate var viewModel = PokemonPageModelView()
        
    var body: some View {
        NavigationStack {
            VStack {
                List(viewModel.list) {
                    pokemon in
                    NavigationLink(destination: DetailPokemonView(pokemon: pokemon)) {
                        PokemonRow(pokemon: pokemon).padding().onAppear(){
                            viewModel.onItemAppear(item: pokemon)
                        }.onLongPressGesture {
                            print("Press")
                            viewModel.onLongPressGesture(pokemon: pokemon)
                        }
                        .swipeActions(edge: .trailing) {
                            Button(action: {
                                print("leading")
                            } ) {
                                Label("Star", systemImage: "star")
                            }
                        }
                    }
                }
                .alert(isPresented: $viewModel.isPresentedAlert) {
                    Alert(title: Text(viewModel.alertPage!.title), message: Text(viewModel.alertPage!.msg), dismissButton: .default(Text(viewModel.alertPage!.buttonOk)))
                }
                
                .onAppear(){
                    viewModel.callbackIsLoading = {
                        print("callbackIsLoading")
                        isLoading.toggle()
                    }
                    viewModel.onAppear(from: self)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Online") {
                        print("Help tapped!")
                    }.foregroundColor(Color.green)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(viewModel.getPage()) {
                        print("Help tapped!")
                    }.foregroundColor(Color.blue)
                }
            }
            .navigationTitle("titlePage1")
        }
        
        .searchable(text: $viewModel.searchText, prompt: "Search")
        .tabItem {
            Label(titleTab, systemImage: titleIcon)
        }
    }
    
    func delete(at offsets: IndexSet) {
        print("delete")
    }
    
}

struct PokemonPageView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonPageView(isLoading: .constant(false))
    }
}
