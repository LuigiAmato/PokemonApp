//
//  PokemonPageViewmodelTest.swift
//  PokemonAppTests
//
//  Created by Amato, Luigi on 03/02/23.
//

import XCTest
import Firebase
@testable import PokemonApp
import SwiftUI


@MainActor class PokemonPageViewmodelTest: XCTestCase,TestBase{
    
    
    var callbackIsLoading: (() -> Void)?
    
    private static var viewModel: PokemonPageViewmodel = PokemonPageViewmodel()
    
    @MainActor override func setUp() {
        super.setUp()
    }
    
    func testStart() async{
        XCTAssertFalse(PokemonPageViewmodelTest.viewModel.list.isEmpty)
        XCTAssertFalse(PokemonPageViewmodelTest.viewModel.listComplete.isEmpty)
        XCTAssertTrue(PokemonPageViewmodelTest.viewModel.searchText == "")
        XCTAssertNotNil(PokemonPageViewmodelTest.viewModel.network)
        XCTAssertNotNil(PokemonPageViewmodelTest.viewModel.coreDM)
        XCTAssertTrue(PokemonPageViewmodelTest.viewModel.limit == 50)
        XCTAssertTrue(PokemonPageViewmodelTest.viewModel.offset == 0)
    }
    
    func testOnAppear() async {
        XCTAssertFalse(PokemonPageViewmodelTest.viewModel.isPresentedAlert)
        XCTAssertNil(PokemonPageViewmodelTest.viewModel.callbackIsLoading)
        XCTAssertNil(PokemonPageViewmodelTest.viewModel.alertPage)
        PokemonPageViewmodelTest.viewModel.onAppear(from: TestBaseView())
        PokemonPageViewmodelTest.viewModel.callbackIsLoading = {}
        XCTAssertNotNil(PokemonPageViewmodelTest.viewModel.callbackIsLoading)
        XCTAssertTrue(PokemonPageViewmodelTest.viewModel.listComplete.count == 50)
        PokemonPageViewmodelTest.viewModel.onItemAppear(item: PokemonItem(id: UUID(), name: "", offset: 0, urlImage: ""))
        XCTAssertTrue(PokemonPageViewmodelTest.viewModel.listComplete.count == 50)
    }
    
    func testAction() async {
        PokemonPageViewmodelTest.viewModel.tapAction(actionTag: ActionTag.actionDone)
    }
    
    func testStartPokemon() async {
        PokemonPageViewmodelTest.viewModel.onLongPressGesture(pokemon: PokemonItem(id: UUID(), name: "", offset: 0, urlImage: ""))
        XCTAssertNotNil(PokemonPageViewmodelTest.viewModel.alertPage)
        XCTAssertTrue(PokemonPageViewmodelTest.viewModel.isPresentedAlert)
    }
    
    func testSearchPokemon() async {
        Task {
            print(PokemonPageViewmodelTest.viewModel.listComplete.count)
            print(PokemonPageViewmodelTest.viewModel.list.count)
            PokemonPageViewmodelTest.viewModel.searchResults(searchText: "")
            print(PokemonPageViewmodelTest.viewModel.listComplete.count)
            print(PokemonPageViewmodelTest.viewModel.list.count)
            XCTAssertTrue(PokemonPageViewmodelTest.viewModel.listComplete.count == 50)
            XCTAssertTrue(PokemonPageViewmodelTest.viewModel.list.count == 50)
            PokemonPageViewmodelTest.viewModel.searchResults(searchText: "bulbasaur")
            XCTAssertTrue(PokemonPageViewmodelTest.viewModel.listComplete.count == 50)
            XCTAssertTrue(PokemonPageViewmodelTest.viewModel.list.count == 1)
           }
    }
}


