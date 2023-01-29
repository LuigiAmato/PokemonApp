//
//  ReaderPage.swift
//  PokemonApp
//
//  Created by Amato, Luigi on 29/01/23.
// 

import SwiftUI
import WebKit

struct ReaderPage: View {
    @Environment(\.dismiss) var dismiss
    public var url:String!
    public var titlePage:String!
     
    var body: some View {
        NavigationStack(){
            WebView(url: url)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(NSLocalizedString("Exit", comment: ""),action: {
                            dismiss()
                        })
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(NSLocalizedString("Save", comment: "")
                               , action: {
                            
                        })
                    }
                }.navigationTitle(titlePage)
        }
    }
}

struct WebView: UIViewRepresentable {
    var url:String
    
    func makeUIView(context: Context) -> some UIView {
        guard let url = URL(string: self.url) else {
            return WKWebView()
        }
        let request = URLRequest(url: url)
        let wk = WKWebView()
        wk.load(request)
        return wk
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
}

struct ReaderPage_Previews: PreviewProvider {
    static var previews: some View {
        ReaderPage(url: "https://toolboxcoworking.com/assets/Termini-e-Condizioni.pdf",titlePage:"Title")
    }
}
