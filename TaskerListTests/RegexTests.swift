//
//  RegexTests.swift
//  TaskerListTests
//
//  Created by Ilya on 26.01.2022.
//

import XCTest
@testable import TaskerList

class RegexTests: XCTestCase {

    override func setUpWithError() throws { }

    override func tearDownWithError() throws { }

    func testName() throws {
        let validName = "Foo Bar"
        XCTAssertTrue(validName.isValid(validType: .name))
        
        let validName2 = "Foo Foo-bar"
        XCTAssertTrue(validName2.isValid(validType: .name))
        
        let invalidName = "Foo Bar2"
        XCTAssertFalse(invalidName.isValid(validType: .name))
    }
    
    func testEmail() throws {
        let validEmail = "foobar@foobar.com"
        XCTAssertTrue(validEmail.isValid(validType: .email))
        
        let invalidEmail = "foobar@foobar"
        XCTAssertFalse(invalidEmail.isValid(validType: .email))
    }
    
    func testPhone() throws {
        let validPhone = "+1 (111) 111-11-11"
        XCTAssertTrue(validPhone.isValid(validType: .phone))
        
        let invalidPhone = "7911684006"
        XCTAssertFalse(invalidPhone.isValid(validType: .phone))
        
        let invalidPhone2 = "м7911684006"
        XCTAssertFalse(invalidPhone2.isValid(validType: .phone))
        
        let invalidPhone3 =  "+1 (111) 1-11-11"
        XCTAssertFalse(invalidPhone3.isValid(validType: .phone))
    }
    
    func testPrice() throws {
        let validPrice = "234"
        XCTAssertTrue(validPrice.isValid(validType: .price))
        
        let invalidPrice = "price 234"
        XCTAssertFalse(invalidPrice.isValid(validType: .price))
        
        let invalidPrice2 = "99999999999999999999999999999999999999999999"
        XCTAssertFalse(invalidPrice2.isValid(validType: .price))
    }
}
