//
//  SignInScreenView.swift
//  PokemonApp
//
//  Created by Amato, Luigi on 29/01/23.
//

import SwiftUI

struct SignInScreenView: View {
    
    @ObservedObject var viewModel: SignInViewModel = SignInViewModel()
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isPresentedReader = false
    @State private var isPresentedMenu = false
    @State private var isPresentedAlert = false

        
    var body: some View {
        ZStack {
            Color("BgColor").edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                VStack {
                    Text("Login")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 30)
                    TextField(viewModel.titleUsername, text: $email)
                        .font(.title3)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(50.0)
                        .shadow(color: Color.black.opacity(0.08), radius: 60, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 16)
                    SecureField(viewModel.titlePassword, text: $password)
                        .font(.title3)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(50.0)
                        .shadow(color: Color.black.opacity(0.08), radius: 60, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 16)
                        .padding(.vertical)
                    PrimaryButton(title: "Accedi").padding(.vertical).fullScreenCover(isPresented: $isPresentedMenu, content: {
                        MenuView()
                    }).onTapGesture {
                        isPresentedMenu.toggle()
                    }
                    createButton(image:  Image(systemName: "highlighter"), text: Text("Registrati"))
                    createButton(image: Image(systemName: "paperplane"), text: Text("Condividi").foregroundColor(Color("PrimaryColor")))
                        .padding(.vertical)
                }
                Spacer()
                Divider()
                Spacer()
                Text("Leggi tutto")
                Text("Terms & Conditions.")
                    .onTapGesture() {
                            isPresentedReader.toggle()
                        }
                    .foregroundColor(Color("PrimaryColor"))
                    .fullScreenCover(isPresented: $isPresentedReader, content: {
                        ReaderPage(url: "https://toolboxcoworking.com/assets/Termini-e-Condizioni.pdf",titlePage: "")
                    })
                Spacer()
            }
            .alert(isPresented: $isPresentedAlert) {
                Alert(title: Text("Important message"), message: Text("Wear sunscreen"), dismissButton: .default(Text("Got it!")))
            }
            .padding()
        }
    }
}

struct SignInScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SignInScreenView(viewModel: SignInViewModel())
    }
}


struct createButton: View {
    var image: Image
    var text: Text
    var body: some View {
        HStack {
            image
                .padding(.horizontal)
            Spacer()
            text
                .font(.title2)
            Spacer()
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(50.0)
        .shadow(color: Color.black.opacity(0.08), radius: 60, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 16)
    }
}
