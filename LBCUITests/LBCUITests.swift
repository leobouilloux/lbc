//
//  LBCUITests.swift
//  LBCUITests
//
//  Created by Leo Marcotte on 24/09/2020.
//  Copyright © 2020 Leo Marcotte. All rights reserved.
//

import XCTest

class LBCUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
    }

    func testExample() throws {
        let app = XCUIApplication()
        app.launch()
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
