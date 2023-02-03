//
//  WelcomeViewmodelTest.swift
//  PokemonAppTests
//
//  Created by Amato, Luigi on 03/02/23.
//

import XCTest
import Firebase
@testable import PokemonApp
import SwiftUI

@MainActor class WelcomeViewmodelTest: XCTestCase,TestBase{
    
    //private var sender: MessageSenderMock!
    private var viewModel: WelcomeViewmodel!

    @MainActor override func setUp() {
        super.setUp()
        viewModel = WelcomeViewmodel()
    }

    func testStart() async{
        XCTAssertFalse(viewModel.isPresentedTour)
        XCTAssertNil(viewModel.alertPage)
        XCTAssertFalse(viewModel.isPresentedAlert)
        XCTAssertFalse(viewModel.isPresentedLogin)
        XCTAssertNil(viewModel.baseView)
    }
    
    func testOnAppear() async {
        viewModel.onAppear(from: TestBaseView())
        XCTAssertNotNil(viewModel.baseView)
    }
    
    func testAction() async {
        viewModel.tapAction(actionTag: ActionTag.actionDone) // for testing default
        viewModel.tapAction(actionTag: ActionTag.actionModal)
        XCTAssertTrue(viewModel.isPresentedAlert)
        XCTAssertFalse(viewModel.isPresentedTour)
        XCTAssertNotNil(viewModel.alertPage)
        viewModel.tapAction(actionTag: ActionTag.actionPlus)
        XCTAssertTrue(viewModel.isPresentedLogin)
    }
}

public protocol TestBase {
    func testStart() async
    func testOnAppear() async
    func testAction() async
}

struct TestBaseView: BaseView {
    var body: some View {
        Text("Prova")
    }
}
