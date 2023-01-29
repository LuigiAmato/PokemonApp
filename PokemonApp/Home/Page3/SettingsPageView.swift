//
//  SettingsPageView.swift
//  PokemonApp
//
//  Created by Amato, Luigi on 29/01/23.
//

import SwiftUI

struct SettingsPageView: View {
    @State public var titleTab = ""
    @State public var titleIcon = ""
    
    var body: some View {
        List {
           ForEach(0..<5) { _ in
             Text("Integer")
           }
        }.tabItem {
            Label(titleTab, systemImage: titleIcon)
        }
    }
}

struct SettingsPageView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsPageView()
    }
}
