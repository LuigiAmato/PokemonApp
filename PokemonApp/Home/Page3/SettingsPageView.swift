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
    
    @StateObject fileprivate var viewModel = SettingsViewmodel()
    @EnvironmentObject var viewModelMenu: MenuViewmodel
  
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Text(self.viewModel.list[0]).padding(.top,20)
                    Text(self.viewModel.list[1])
                    Text(self.viewModel.list[2])
                    Text(self.viewModel.list[3])
                    Text(self.viewModel.list[4]).padding(.bottom,20)
                }
            }.toolbar(content: {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Logout") {
                        viewModelMenu.tapAction(actionTag: .actionExitPage)
                    }.foregroundColor(Color("divider"))
                }
            })
            .navigationTitle(self.titleTab)
        }
        .alert(isPresented: $viewModel.isPresentedAlert) {
            Alert(title: Text(viewModel.alertPage!.title), message: Text(viewModel.alertPage!.msg), dismissButton: .default(Text(viewModel.alertPage!.buttonOk)))
        }
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
