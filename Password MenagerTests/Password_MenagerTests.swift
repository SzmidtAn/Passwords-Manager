//
//  Password_MenagerTests.swift
//  Password MenagerTests
//
//  Created by Aneta Szmidt on 2021-02-18.
//
import SwiftUI

import XCTest
@testable import Password_MEnager

class Password_MenagerTests: XCTestCase {

    var loginView : ifUserLogoView! = nil
    @State var unlock = true


    override func setUp() {
        //given
        loginView =  ifUserLogoView(isUnlocked: $unlock)

    }
    
    func testCanShowName() throws {
        

        //when
        let result = loginView.authentication()
        //then
        XCTAssertTrue(result)
        
    }

}
