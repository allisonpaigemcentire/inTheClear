//
//  inTheClearTests.swift
//  inTheClearTests
//
//  Created by Allison Mcentire on 5/8/22.
//

import XCTest
@testable import inTheClear

class inTheClearTests: XCTestCase {
    
    private var SUT: CalculationManager!

    override func setUp() {
        super.setUp()
        SUT = CalculationManager()
        SUT.defaults = MockUserDefaults()
    }

    override func tearDown() {
        SUT = nil
        super.tearDown()
    }

    func test_checkForUserDefaultsData_ReturnsExpectedBool() {
        XCTAssertTrue(SUT.checkForUserDefaultsData())
    }
    
    func test_clearUserDefaults_checkForUserDefaultsData_ReturnsExpectedBool() {
        SUT.clearUserDefaults()
        XCTAssertFalse(SUT.checkForUserDefaultsData())
    }
    
    func test_getCurrentPeriodStartDate_numberOfDaysInCurrentPeriod_ReturnsExpectedInt() {
        XCTAssertEqual(SUT.numberOfDaysInCurrentPeriod(), 0)
        SUT.recordCurrentPeriodStartDate()
        XCTAssertEqual(SUT.numberOfDaysInCurrentPeriod(), 1)
    }
    
    func test_averageDaysInCycle_returnsExpectedInt() {
        XCTAssertEqual(29, SUT.averageDaysInCycle())
    }
    
    func test_daysUntilNextPeriod_returnsExpectedInt() {
        XCTAssertEqual(15, SUT.numberOfDaysUntilNextPeriod())
    }
}
