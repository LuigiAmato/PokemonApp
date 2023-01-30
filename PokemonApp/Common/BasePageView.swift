//
//  BasePageView.swift
//  PokemonApp
//
//  Created by Amato, Luigi on 29/01/23.
//

import SwiftUI

struct BasePageView: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding public var isLoading: Bool

    var body: some View {
        ZStack {
            let colorAnimation:Color = colorScheme == .dark ? .white : .black
            if self.isLoading {
                if colorScheme == .dark {
                    Color.white.opacity(0.55).edgesIgnoringSafeArea(.all)
                }
                else {
                    Color.black.opacity(0.55).edgesIgnoringSafeArea(.all)
                }
                ActivityIndicator().padding(1.0).frame(width: 50,height: 50).foregroundColor(colorAnimation)
            }
        }
    }
}


struct BasePageView_Previews: PreviewProvider {
    static var previews: some View {
        BasePageView(isLoading: .constant(false))
    }
}

protocol BaseView: View {
}


