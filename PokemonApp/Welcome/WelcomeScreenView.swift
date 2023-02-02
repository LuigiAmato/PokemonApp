//
//  WelcomeScreenView.swift
//  PokemonApp
//
//  Created by Amato, Luigi on 29/01/23.
//

import SwiftUI

struct WelcomeScreenView: BaseView {
    
    @ObservedObject var viewModel: WelcomeViewmodel = WelcomeViewmodel()
        
    var body: some View {
        NavigationView {
            ZStack {
                Color("BgColor").edgesIgnoringSafeArea(.all)
                VStack {
                    bodyCenter()
                }
                .padding()
            }
            .alert(isPresented: $viewModel.isPresentedAlert) {
                Alert(title: Text(viewModel.alertPage!.title), message: Text(viewModel.alertPage!.msg), dismissButton: .default(Text(viewModel.alertPage!.buttonOk)))
            }
        }.onAppear(){
            self.viewModel.onAppear(from: self)
        }
    }
    
    private func bodyCenter() -> some View {
        let view = NavigationStack {
            Spacer().frame(height: 100)
            Image(uiImage: #imageLiteral(resourceName: "onboard")).resizable().frame(width: 250,height: 195)
            Spacer()
            PrimaryButton(title: NSLocalizedString("tour", comment: "")).onTapGesture {
                self.viewModel.tapAction(actionTag: .actionModal)
            }
            Text("pageLogin")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(Color.white)
                .padding()
                .frame(maxWidth: .infinity)
                .shadow(color: Color.black.opacity(0.08), radius: 60, x: 0.0, y: 16)
                .background(Color("SecondaryColor"))
                .cornerRadius(50.0)
                .padding(.vertical).onTapGesture {
                    self.viewModel.tapAction(actionTag: .actionPlus)
                }
                .navigationDestination(isPresented: $viewModel.isPresentedLogin,destination:{ SignInScreenView(viewModel: SignInViewmodel()).navigationBarHidden(true)
                })
            Spacer()
            HStack {
                Text("Version 1.0")
            }
        }.navigationBarHidden(true)
        return view;
    }
}

struct WelcomeScreenView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreenView()
    }
}

