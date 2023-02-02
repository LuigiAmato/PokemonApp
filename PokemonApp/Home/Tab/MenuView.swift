//
//  MenuView.swift
//  PokemonApp
//
//  Created by Amato, Luigi on 29/01/23.
//

import SwiftUI

struct MenuView: BaseView {
    @StateObject fileprivate var viewModel = MenuViewmodel()
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            
            TabView() {
                    PokemonPageView(isLoading: $viewModel.isLoading)
                    PokemonStarPageView().environmentObject(viewModel)
                    SettingsPageView().environmentObject(viewModel)
                }.onAppear(){
                    viewModel.onAppear(from: self)
                }
                BasePageView(isLoading: $viewModel.isLoading)
            
        }
    }
    
    func dismissPage() {
        dismiss()
    }
    
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
