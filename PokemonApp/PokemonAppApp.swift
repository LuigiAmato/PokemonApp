//
//  PokemonAppApp.swift
//  PokemonApp
//
//  Created by Amato, Luigi on 27/01/23.
//

import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    return true
  }
}

@main
struct PokemonAppApp: App {
    // register app delegate for Firebase setup
     //@UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
