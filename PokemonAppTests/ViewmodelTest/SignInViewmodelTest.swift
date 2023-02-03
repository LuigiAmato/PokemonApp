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
    
    private static let signIn = SignInScreenView()
    private var view:SignInScreenView!
    private var viewModel: SignInViewmodel!

    @MainActor override func setUp() {
        super.setUp()
        view = SignInViewmodelTest.signIn
        viewModel = SignInViewmodelTest.signIn.viewModel
    }
    
    func testOnAppear() async {
        viewModel.onAppear(from:view)
        XCTAssertNotNil(viewModel.baseView)
        let pass = view.Password;
        XCTAssertNotNil(pass)
        let registration = view.Registration;
        XCTAssertNotNil(registration)
        let body = view.body;
        XCTAssertNotNil(body)
        let button = createButton(image: Image(systemName: "Star"), text: Text(""), backgroundColor: Color.red);
        XCTAssertNotNil(button)
    }
    
    func testAction() async {
        XCTAssertTrue(viewModel.createUser == "")
        XCTAssertTrue(viewModel.createPassword == "")
        XCTAssertFalse(viewModel.isPresentedMenu)
        XCTAssertFalse(viewModel.isPresentedAlert)
        XCTAssertFalse(viewModel.isPresentedReader)
        XCTAssertFalse(viewModel.showPassword)
        XCTAssertFalse(viewModel.presentSheet)
        XCTAssertTrue(viewModel.email == "")
        XCTAssertTrue(viewModel.password == "")
        XCTAssertNil(viewModel.baseView)
        XCTAssertNil(viewModel.alertPage)
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
        XCTAssertTrue(viewModel.urlTermsCond.count != 0)

        viewModel.tapAction(actionTag: ActionTag.actionCreateUser)
        XCTAssertTrue(viewModel.presentSheet)
        viewModel.createUser = "test@gmail.com"
        viewModel.createPassword = "Password1"
        viewModel.email = "test@gmail.com"
        viewModel.password = "Password1!"
        viewModel.tapAction(actionTag: ActionTag.actionDone)
        Task {
            XCTAssertTrue(self.viewModel.isPresentedMenu)
        }
    }
    
    func testStart() async{
        let reader = ReaderPage(url: "test",titlePage: "title")
        let body = reader.body
        XCTAssertFalse(reader.titlePage.isEmpty)
        XCTAssertFalse(reader.url.isEmpty)
        XCTAssertNotNil(body)
        XCTAssertNotNil(reader.actionSheet())
        let web = WebView(url: "http://www.google.com")
        XCTAssertNotNil(web)
        XCTAssertNotNil(web.delegateWeb)
        XCTAssertFalse(web.url.isEmpty)
        let base = BasePageView(isLoading: .constant(false))
        XCTAssertNotNil(base)
        XCTAssertNotNil(base.body)
        XCTAssertFalse(base.isLoading)
        Analytics.action(type: .LoginAction)
        CoreDataManager().deleteItem(name: "Prova")
        
    }
}
