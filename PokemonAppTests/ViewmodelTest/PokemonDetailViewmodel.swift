//
//  PokemonDetailViewmodel.swift
//  PokemonAppTests
//
//  Created by Amato, Luigi on 03/02/23.
//

import XCTest
import Firebase
@testable import PokemonApp
import SwiftUI

@MainActor class PokemonDetailViewmodelTest: XCTestCase,TestBase{
    
    private static var viewModel: DetailPokemonViewmodel = DetailPokemonViewmodel()

    @MainActor override func setUp() {
        super.setUp()
    }

    func testStart() async{
        XCTAssertNil(PokemonDetailViewmodelTest.viewModel.callbackIsLoading)
        XCTAssertNotNil(PokemonDetailViewmodelTest.viewModel.coreDM)
        XCTAssertNotNil(PokemonDetailViewmodelTest.viewModel.network)
        XCTAssertNil(PokemonDetailViewmodelTest.viewModel.abilityDetail)
        XCTAssertTrue(PokemonDetailViewmodelTest.viewModel.abilityNameSelected.isEmpty)
    }
    
    func testOnAppear() async {
        XCTAssertNil(PokemonDetailViewmodelTest.viewModel.pokemon)
        XCTAssertTrue(PokemonDetailViewmodelTest.viewModel.stats.isEmpty)
        XCTAssertTrue(PokemonDetailViewmodelTest.viewModel.ability.isEmpty)
        XCTAssertTrue(PokemonDetailViewmodelTest.viewModel.abilities.isEmpty)
        XCTAssertTrue(PokemonDetailViewmodelTest.viewModel.base_experience == 0)
        PokemonDetailViewmodelTest.viewModel.setPokemon(pokemon: PokemonItem(id: UUID(), name: "Bulbasaur", offset: 50, urlImage:""))
        PokemonDetailViewmodelTest.viewModel.onAppear(from: TestBaseView())
    }
    
    func testStartPokemon() async {
        XCTAssertFalse(PokemonDetailViewmodelTest.viewModel.presentSheet)
        XCTAssertNil(PokemonDetailViewmodelTest.viewModel.alertPage)
        XCTAssertFalse(PokemonDetailViewmodelTest.viewModel.isPresentedAlert)
        PokemonDetailViewmodelTest.viewModel.onLongPressGesture(pokemon: PokemonItem(id: UUID(), name: "", offset: 0, urlImage: ""))
        XCTAssertNotNil(PokemonDetailViewmodelTest.viewModel.alertPage)
        XCTAssertTrue(PokemonDetailViewmodelTest.viewModel.isPresentedAlert)
        PokemonDetailViewmodelTest.viewModel.onAppearSheet(abilityName: "bulbasaur")
        XCTAssertTrue(PokemonDetailViewmodelTest.viewModel.presentSheet)
        XCTAssertNotNil(PokemonDetailViewmodelTest.viewModel.abilityDetail)
        XCTAssertFalse(PokemonDetailViewmodelTest.viewModel.abilityNameSelected.isEmpty)
    }
    
    func testAction() async {
        PokemonDetailViewmodelTest.viewModel.tapAction(actionTag: .actionDone)
    }
}

