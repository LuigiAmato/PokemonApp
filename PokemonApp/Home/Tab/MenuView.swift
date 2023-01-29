//
//  MenuView.swift
//  PokemonApp
//
//  Created by Amato, Luigi on 29/01/23.
//

import SwiftUI

struct MenuView: View {
    
    init() {
        //UITabBar.appearance().backgroundColor = UIColor.gray
    }
    
    @State private var isPresented = false
    @State private var isLoading = false

    var body: some View {
        
        ZStack {
            TabView {
                PokemonPageView(titleTab: "Pokèmon",titleIcon: "list.number",isLoading: $isLoading)
                PokemonStarPageView(titleTab: "Preferiti",titleIcon: "list.star")       
                SettingsPageView(titleTab: "Impostazioni",titleIcon: "lanyardcard.fill")
            }.onAppear(){
                print("onAppear MenuView")
            }
            BasePageView(isLoading: $isLoading)
        }

    }
    
}

struct MenuView_Previews: PreviewProvider {

    static var previews: some View {
        MenuView()
    }
}
