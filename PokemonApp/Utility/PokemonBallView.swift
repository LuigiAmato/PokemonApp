//
//  PokemonBallView.swift
//  PokemonApp
//
//  Created by Amato, Luigi on 29/01/23.
//

import SwiftUI

struct PokemonBallView: View {
    public var size = 200.0
    var body: some View {
        ZStack {
            Color.black
            VStack {
                Color.red
                Color.white
            }
            ZStack {
                Color.black
                ZStack {
                    Color.white
                }.frame(width: size/10,height: size/10).cornerRadius(size/10/2)
            }.frame(width: size/5,height: size/5).cornerRadius(size/5/2)
        }
        .frame(width: size,height: size).frame(width: size, height: size) .cornerRadius(size/2)
            .overlay(RoundedRectangle(cornerRadius: size/2)
                .stroke(Color.black, lineWidth: 1)).shadow(radius: 10)
    }
}

struct PokemonBallView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonBallView(size: 200.0)
    }
}
