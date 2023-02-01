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
                            actionSheet()
                        })
                    }
                }.navigationTitle(titlePage)
        }
    }
    
    func actionSheet() {
        guard let urlShare = URL(string: url) else { return }
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        let count = UIApplication.shared.windows.count
        UIApplication.shared.windows[count-1].rootViewController?.present(activityVC, animated: true, completion: nil)
        /*
        let config = WKPDFConfiguration()
        wk.createPDF(configuration: config){ result in
            switch result{
            case .success(let data):
                guard let urlShare = URL(string: url) else { return }
                let activityVC = UIActivityViewController(activityItems: [data], applicationActivities: nil)
                let count = UIApplication.shared.windows.count
                UIApplication.shared.windows[count-1].rootViewController?.present(activityVC, animated: true, completion: nil)
            case .failure(let error):
                print(error)
            }
        }
         */
    }
}

struct WebView: UIViewRepresentable {
    var url:String
    let wk = WKWebView()
    let delegateWeb = WebViewHelper()
    func makeUIView(context: Context) -> some UIView {
        guard let url = URL(string: self.url) else {
            return WKWebView()
        }
        let request = URLRequest(url: url)
        wk.navigationDelegate = delegateWeb
        wk.load(request)
        return wk
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }

}


class WebViewHelper: NSObject, WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("webview didFinishNavigation")
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("didStartProvisionalNavigation")
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        print("webviewDidCommit")
    }
    
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        print("didReceiveAuthenticationChallenge")
        completionHandler(.performDefaultHandling, nil)
    }
}

struct ReaderPage_Previews: PreviewProvider {
    static var previews: some View {
        ReaderPage(url: "https://toolboxcoworking.com/assets/Termini-e-Condizioni.pdf",titlePage:"Title")
    }
}
