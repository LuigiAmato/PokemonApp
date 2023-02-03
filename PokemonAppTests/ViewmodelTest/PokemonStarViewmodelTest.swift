//
//  PokemonStarViewmodelTest.swift
//  PokemonAppTests
//
//  Created by Amato, Luigi on 03/02/23.
//

import XCTest
import Firebase
@testable import PokemonApp
import SwiftUI

@MainActor class PokemonStarViewmodelTest: XCTestCase,TestBase{
    
    private static var view = PokemonStarPageView()
    private var viewModel:PokemonStarViewmodel!

    @MainActor override func setUp() {
        super.setUp()
        self.viewModel = PokemonStarViewmodelTest.view.viewModel
    }

    func testStart() async{
        XCTAssertNotNil(self.viewModel.coreDM)
        XCTAssertNotNil(self.viewModel.list)
        XCTAssertNotNil(PokemonStarViewmodelTest.view.body)
    }
    
    func testOnAppear() async {
        XCTAssertNil(self.viewModel.alertPage)
        XCTAssertFalse(self.viewModel.isPresentedAlert)
        self.viewModel.onAppear(from: PokemonStarViewmodelTest.view)
        XCTAssertNotNil(PokemonStarViewmodelTest.view.body)
    }
    
    func testStartPokemon() async {
        self.viewModel.onLongPressGesture(pokemon: PokemonItem(id: UUID(), name: "", offset: 0, urlImage: ""))
        XCTAssertNotNil(self.viewModel.alertPage)
        XCTAssertTrue(self.viewModel.isPresentedAlert)
        XCTAssertNotNil(PokemonStarViewmodelTest.view.body)
    }
    
    func testAction() async {
        self.viewModel.tapAction(actionTag: .actionDone)
        XCTAssertNotNil(PokemonStarViewmodelTest.view.body)
    }
    
    func testView() async {
        let pokemon = PokemonItem(id: UUID(), name: "Bulbasauro", offset: 0, urlImage: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/3.png")
        XCTAssertNotNil(PokemonBallView(size: 100))
        XCTAssertNotNil(PokemonBallView(size: 100).body)
        XCTAssertNotNil(PokemonRow(pokemon: pokemon))
        XCTAssertNotNil(PokemonRow(pokemon: pokemon).body)
        XCTAssertNotNil(PokemonRow(pokemon: pokemon).ImageView)
        XCTAssertNotNil(DetailPokemonView(pokemon: pokemon))
        XCTAssertNotNil(DetailPokemonView(pokemon: pokemon).body)
        XCTAssertNotNil(SettingsPageView())
        XCTAssertNotNil(SettingsPageView().body)
        XCTAssertNotNil(MenuView())
        XCTAssertNotNil(MenuView().body)
        XCTAssertNotNil(ActivityIndicator())
        XCTAssertNotNil(ActivityIndicator().body)
        let basePage = BasePageView(isLoading: .constant(false))
        XCTAssertNotNil(basePage)
        XCTAssertNotNil(basePage.body)
        basePage.isLoading.toggle()
        XCTAssertNotNil(basePage.body)
        
        XCTAssertNotNil(PokemonStarPageView_Previews.previews)
        let startPage = PokemonStarPageView()
        XCTAssertNotNil(startPage)
        XCTAssertNotNil(startPage.body)
        XCTAssertNotNil(startPage.body)

    }
}
