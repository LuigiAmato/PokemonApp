//
//  SignInScreenView.swift
//  PokemonApp
//
//  Created by Amato, Luigi on 29/01/23.
//

import SwiftUI

struct SignInScreenView: BaseView {
    
    @ObservedObject var viewModel: SignInViewmodel = SignInViewmodel()
    
    
    var Password: some View {
        ZStack(alignment: .trailing) {
            Group {
                if viewModel.showPassword {
                    TextField("pass", text: $viewModel.password)  .font(.title3)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color("placeholder"))                  .cornerRadius(50.0)
                        .shadow(color: Color.black.opacity(0.08), radius: 60, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 16)
                        .padding(.vertical)
                        .foregroundColor(Color("textColor"))
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                        .disableAutocorrection(true)
                } else {
                    SecureField("pass", text: $viewModel.password)
                        .font(.title3)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color("placeholder"))                  .cornerRadius(50.0)
                        .shadow(color: Color.black.opacity(0.08), radius: 60, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 16)
                        .padding(.vertical)
                        .foregroundColor(Color("textColor"))
                }
            }
            Button(action: {
                self.viewModel.tapAction(actionTag: ActionTag.actionPassword)
            }) {
                Image(systemName: viewModel.showPassword ? "eye" : "eye.slash")
                    .accentColor(.gray)
            }.padding(.trailing,20)
            
        }
    }
    
    var body: some View {
        ZStack {
            Color("BgColor").edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                VStack {
                    Text("pageLogin")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 30)
                    
                    TextField("user", text: $viewModel.email)
                        .font(.title3)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color("placeholder"))
                        .foregroundColor(Color("textColor"))
                        .cornerRadius(50.0)
                        .shadow(color: Color.black.opacity(0.08), radius: 60, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 16).autocapitalization(.none)
                        .keyboardType(.emailAddress)
                        .disableAutocorrection(true)
                    Password
                    PrimaryButton(title: NSLocalizedString("buttonA", comment: "")).padding(.vertical).fullScreenCover(isPresented: $viewModel.isPresentedMenu, content: {
                        MenuView()
                    }).onTapGesture {
                        self.viewModel.tapAction(actionTag: .actionDone)
                    }
                    createButton(image:  Image(systemName: "highlighter"), text: Text("buttonR"), backgroundColor: Color("SecondaryColor"))
                        .onTapGesture {
                            self.viewModel.tapAction(actionTag: .actionOther)
                        }
                    createButton(image: Image(systemName: "paperplane"), text: Text("buttonS"), backgroundColor: Color("PrimaryColor"))
                        .padding(.vertical).onTapGesture {
                            self.viewModel.tapAction(actionTag: .actionPlus)
                        }
                }
                Spacer()
                Divider().background(Color("divider"))
                Spacer()
                Text("read")
                Text("terms&condition")
                    .onTapGesture() {
                        self.viewModel.tapAction(actionTag: .actionModal)
                    }
                    .foregroundColor(Color("PrimaryColor"))
                    .fullScreenCover(isPresented: $viewModel.isPresentedReader, content: {
                        ReaderPage(url:viewModel.urlTermsCond ,titlePage: NSLocalizedString("terms&condition", comment: ""))
                    })
                Spacer()
            }
            .alert(isPresented: $viewModel.isPresentedAlert) {
                Alert(title: Text(viewModel.alertPage!.title), message: Text(viewModel.alertPage!.msg), dismissButton: .default(Text(viewModel.alertPage!.buttonOk)))
            }
            .onAppear(){
                self.viewModel.onAppear(from: self)
            }
            .padding()
        }
    }
    
}

struct SignInScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SignInScreenView(viewModel: SignInViewmodel())
    }
}


struct createButton: View {
    var image: Image
    var text: Text
    var backgroundColor: Color
    var body: some View {
        HStack {
            image
                .padding(.horizontal)
            Spacer()
            text
                .font(.title2).foregroundColor(.white)                .fontWeight(.bold)
            Spacer()
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(backgroundColor)
        .cornerRadius(50.0)
        .shadow(color: Color.black.opacity(0.08), radius: 60, x: /*@START_MENU_TOKEN@*/0.0/*@END_MENU_TOKEN@*/, y: 16)
    }
}
