//
//  mySampleSkillsTests.swift
//  mySampleSkillsTests
//
//  Created by Ivan Santos on 15/01/23.
//

import XCTest
@testable import mySampleSkills

final class MySampleSkillsTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let mvc = ViewController()
        mvc.isUnitTesting = true
        mvc.getStore()
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
