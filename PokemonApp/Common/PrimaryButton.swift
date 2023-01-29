//
//  PrimaryButton.swift
//  PokemonApp
//
//  Created by Amato, Luigi on 29/01/23.
//

import SwiftUI

struct PrimaryButton: View {
    var title: String
    var body: some View {
        Text(title)
            .font(.title3)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding()
            .background(Color("PrimaryColor"))
            .cornerRadius(50)
    }
}

struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryButton(title: "Preview")
    }
}
