//
//  MockProviderTests.swift
//  LBCTests
//
//  Created by Leo Marcotte on 24/09/2020.
//  Copyright © 2020 Leo Marcotte. All rights reserved.
//

@testable import LBC
import XCTest

class MockProviderTests: XCTestCase {
    func testFetchDataSuccess() throws {
        // GIVEN
        let dataExpectation = expectation(description: "data has been fetched")
        let provider = MockProvider(config: .success)

        // WHEN
        provider.fetchData { result in
            // THEN
            switch result {
            case let .success(items):
                XCTAssertFalse(items.isEmpty)
            default: XCTFail("items were not returned")
            }
            dataExpectation.fulfill()
        }
        wait(for: [dataExpectation], timeout: 10)
    }

    func testFetchDataReadFileError() throws {
        // GIVEN
        let errorExpectation = expectation(description: "cannotReadFile error has been returned")
        let provider = MockProvider(config: .generateError(ofType: .cannotReadFile))

        // WHEN
        provider.fetchData { result in
            // THEN
            switch result {
            case let .failure(error):
                XCTAssertTrue((error as? MockError) == MockError.cannotReadFile)
            default: XCTFail("items have been returned")
            }
            errorExpectation.fulfill()
        }
        wait(for: [errorExpectation], timeout: 10)
    }

    func testFetchDataDeserializationFailedError() throws {
        // GIVEN
        let errorExpectation = expectation(description: "deserializationFailed error has been returned")
        let provider = MockProvider(config: .generateError(ofType: .deserializationFailed))

        // WHEN
        provider.fetchData { result in
            // THEN
            switch result {
            case let .failure(error):
                XCTAssertTrue((error as? MockError) == MockError.deserializationFailed)
            default: XCTFail("items have been returned")
            }
            errorExpectation.fulfill()
        }
        wait(for: [errorExpectation], timeout: 10)
    }
}
