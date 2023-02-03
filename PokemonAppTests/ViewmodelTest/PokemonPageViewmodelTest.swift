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
        
    private static let pokemonPageView = PokemonPageView(isLoading: .constant(false))
    private var view:PokemonPageView!
    private var viewModel: PokemonPageViewmodel!

    @MainActor override func setUp() {
        super.setUp()
        view = PokemonPageViewmodelTest.pokemonPageView
        viewModel = view.viewModel
    }

    func testStart() async{
        XCTAssertTrue(self.viewModel.searchText == "")
        XCTAssertNotNil(self.viewModel.network)
        XCTAssertNotNil(self.viewModel.coreDM)
        XCTAssertTrue(self.viewModel.limit == 50)
        XCTAssertTrue(self.viewModel.offset == 0)
        XCTAssertNotNil(view.body)
    }
    
    func testOnAppear() async {
        XCTAssertTrue(self.viewModel.list.isEmpty)
        XCTAssertTrue(self.viewModel.listComplete.isEmpty)
        XCTAssertFalse(self.viewModel.isPresentedAlert)
        XCTAssertNil(self.viewModel.callbackIsLoading)
        XCTAssertNil(self.viewModel.alertPage)
        self.viewModel.onAppear(from: view)
        self.viewModel.callbackIsLoading = {}
        XCTAssertNotNil(self.viewModel.callbackIsLoading)
        XCTAssertTrue(self.viewModel.listComplete.count == 50)
        self.viewModel.onItemAppear(item: PokemonItem(id: UUID(), name: "", offset: 0, urlImage: ""))
        XCTAssertTrue(self.viewModel.list.count == 50)
        self.viewModel.searchResults(searchText: "bulbasaur")
        XCTAssertTrue(self.viewModel.listComplete.count == 50)
        XCTAssertTrue(self.viewModel.list.count == 1)
        XCTAssertNotNil(view.body)
    }
    
    func testAction() async {
        self.viewModel.tapAction(actionTag: ActionTag.actionDone)
    }
    
    func testStartPokemon() async {
        self.viewModel.onLongPressGesture(pokemon: PokemonItem(id: UUID(), name: "", offset: 0, urlImage: ""))
        XCTAssertNotNil(self.viewModel.alertPage)
        XCTAssertTrue(self.viewModel.isPresentedAlert)
        XCTAssertNotNil(view.body)
    }
    
    func testSearchPokemon() async {
        Task {
            print(self.viewModel.listComplete.count)
            print(self.viewModel.list.count)
            self.viewModel.searchResults(searchText: "")
            print(self.viewModel.listComplete.count)
            print(self.viewModel.list.count)
        }
    }
}



