//
//  HomeViewModel.swift
//  PokemonAppTests
//
//  Created by Amato, Luigi on 03/02/23.
//

import XCTest
import Firebase
@testable import PokemonApp
import SwiftUI

@MainActor class HomeViewModel: XCTestCase,TestBase{
    
    //private var sender: MessageSenderMock!
    private var viewModel: MenuViewmodel!

    @MainActor override func setUp() {
        super.setUp()
        viewModel = MenuViewmodel()
    }
    
    var alertPage: AlertPage?
    @Published var isPresentedAlert: Bool = false
    @Published var isLoading: Bool = false

    func testStart() async{
        XCTAssertFalse(viewModel.isPresentedAlert)
        XCTAssertNil(viewModel.alertPage)
        XCTAssertFalse(viewModel.isLoading)
    }
    
    func testOnAppear() async {
        viewModel.onAppear(from: TestBaseView())
        XCTAssertNotNil(viewModel.view)
    }
    
    func testAction() async {
        viewModel.tapAction(actionTag: ActionTag.actionDone)
        viewModel.tapAction(actionTag: ActionTag.actionExitPage)
   
    }
}

