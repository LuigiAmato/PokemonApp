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
}
