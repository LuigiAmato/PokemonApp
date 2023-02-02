//
//  SettingsPageView.swift
//  PokemonApp
//
//  Created by Amato, Luigi on 29/01/23.
//

import SwiftUI

struct SettingsPageView: BaseView {
    
    private var titleTab = NSLocalizedString("titlePage3", comment: "")
    private var titleIcon = "lanyardcard.fill"
    
    @StateObject fileprivate var viewModel = PokemonStarViewmodel()
    @EnvironmentObject var viewModelMenu: MenuViewmodel
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(0..<5) { _ in
                    Text("Integer")
                }
            }.tabItem {
                Label(titleTab, systemImage: titleIcon)
            }
        }
        .alert(isPresented: $viewModel.isPresentedAlert) {
            Alert(title: Text(viewModel.alertPage!.title), message: Text(viewModel.alertPage!.msg), dismissButton: .default(Text(viewModel.alertPage!.buttonOk)))
        }
        .navigationTitle(self.titleTab)
        .onAppear(){
            viewModel.onAppear(from: self)
        }
        .tabItem {
            Label(titleTab, systemImage: titleIcon)
        }
    }
    
}

struct SettingsPageView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsPageView()
    }
}
