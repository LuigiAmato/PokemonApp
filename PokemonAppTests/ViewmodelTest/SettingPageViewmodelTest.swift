//
//  SettingPageViewmodelTest.swift
//  PokemonAppTests
//
//  Created by Amato, Luigi on 03/02/23.
//

import XCTest
import Firebase
@testable import PokemonApp
import SwiftUI

@MainActor class SettingPageViewmodelTest: XCTestCase,TestBase{
    
    //private var sender: MessageSenderMock!
    private var viewModel: SettingsViewmodel!

    @MainActor override func setUp() {
        super.setUp()
        viewModel = SettingsViewmodel()
    }

    func testStart() async{
        XCTAssertFalse(viewModel.isPresentedAlert)
        XCTAssertNil(viewModel.alertPage)
        XCTAssertFalse(viewModel.list.count == 0)
    }
    
    func testOnAppear() async {
        viewModel.onAppear(from: TestBaseView())
        XCTAssertNotNil(viewModel.baseView)
    }
    
    func testAction() async {
        viewModel.tapAction(actionTag: ActionTag.actionDone)
        viewModel.tapAction(actionTag: ActionTag.actionExitPage)
        viewModel.tapAction(actionTag: ActionTag.actionExitPage)
        XCTAssertTrue(viewModel.isPresentedAlert)
        XCTAssertNotNil(viewModel.alertPage)
    }
}


