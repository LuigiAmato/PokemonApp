//
//  ContentView.swift
//  PokemonApp
//
//  Created by Amato, Luigi on 27/01/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        //WelcomeScreenView()
        ReaderPage(url: "https://toolboxcoworking.com/assets/Termini-e-Condizioni.pdf")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
