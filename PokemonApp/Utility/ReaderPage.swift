//
//  ReaderPage.swift
//  PokemonApp
//
//  Created by Amato, Luigi on 29/01/23.
// 

import SwiftUI
import WebKit

struct ReaderPage: UIViewRepresentable {
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
