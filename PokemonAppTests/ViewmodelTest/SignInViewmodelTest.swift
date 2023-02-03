//
//  SignInViewmodelTest.swift
//  PokemonAppTests
//
//  Created by Amato, Luigi on 03/02/23.
//

import XCTest
import Firebase
@testable import PokemonApp
import SwiftUI

@MainActor class SignInViewmodelTest: XCTestCase,TestBase{
    
    //private var sender: MessageSenderMock!
    private var viewModel: SignInViewmodel!

    @MainActor override func setUp() {
        super.setUp()
        viewModel = SignInViewmodel()
    }

    func testStart() async{
        XCTAssertFalse(viewModel.isPresentedMenu)
        XCTAssertNil(viewModel.alertPage)
        XCTAssertFalse(viewModel.isPresentedAlert)
        XCTAssertFalse(viewModel.isPresentedReader)
        XCTAssertFalse(viewModel.showPassword)
        XCTAssertFalse(viewModel.presentSheet)
        XCTAssertNil(viewModel.baseView)
        XCTAssertTrue(viewModel.email == "")
        XCTAssertTrue(viewModel.password == "")
        XCTAssertTrue(viewModel.createUser == "")
        XCTAssertTrue(viewModel.createPassword == "")
    }
    
    func testOnAppear() async {
        viewModel.onAppear(from: TestBaseView())
        XCTAssertNotNil(viewModel.baseView)
    }
    
    func testAction() async {
        viewModel.tapAction(actionTag: ActionTag.actionDone)
        XCTAssertTrue(viewModel.email == "")
        XCTAssertTrue(viewModel.password == "")
        XCTAssertNotNil(viewModel.alertPage)
        XCTAssertTrue(viewModel.isPresentedAlert)
        viewModel.isPresentedAlert.toggle() // chiudo alert
        viewModel.tapAction(actionTag: ActionTag.actionPassword)
        XCTAssertTrue(viewModel.showPassword)
        viewModel.tapAction(actionTag: ActionTag.actionModal)
        XCTAssertTrue(viewModel.isPresentedReader)
        viewModel.tapAction(actionTag: ActionTag.actionPlus)
        XCTAssertTrue(viewModel.isPresentedAlert)
        viewModel.tapAction(actionTag: ActionTag.actionOther)
        XCTAssertTrue(viewModel.presentSheet)
        viewModel.tapAction(actionTag: ActionTag.actionExitPage) // default
        viewModel.email = "test@gmail.com"
        viewModel.password = "Password1!"
        viewModel.tapAction(actionTag: ActionTag.actionDone)
        let secondsToDelay = 1.0
           DispatchQueue.main.asyncAfter(deadline: .now() + secondsToDelay) {
               print("test menu")
               XCTAssertTrue(self.viewModel.isPresentedMenu)
        }
    }
}
