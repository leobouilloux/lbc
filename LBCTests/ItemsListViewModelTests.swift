//
//  ItemsListViewModelTests.swift
//  LBCTests
//
//  Created by Leo Marcotte on 30/09/2020.
//  Copyright © 2020 Leo Marcotte. All rights reserved.
//

import XCTest
@testable import LBC

class ItemsListViewModelTests: XCTestCase {
    func testFetchItemsSuccess() throws {
        // GIVEN
        let itemsExpectation = expectation(description: "Data downloaded")
        let provider: Provider = MockProvider(config: .success)
        let viewModel = ItemsListViewModel(provider: provider)

        // WHEN
        viewModel.fetchItems()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertFalse(viewModel.items.isEmpty)
            itemsExpectation.fulfill()
        }
        
        // THEN
        waitForExpectations(timeout: 10)
    }
    
    func testFiltersSuccess() throws {
        // GIVEN
        let provider: Provider = MockProvider(config: .success)
        let viewModel = ItemsListViewModel(provider: provider)
        let mockedFilters: [CategoryFilter] = ItemCategory.allCases.compactMap({ category in
            return CategoryFilter(itemCategory: category)
        })

        // WHEN
        viewModel.filters = []
        viewModel.setupFilters()
        
        // THEN
        XCTAssertTrue(mockedFilters == viewModel.filters)
    }
    
    func testToggleCategorySuccess() throws {
        // GIVEN
        let provider: Provider = MockProvider(config: .success)
        let viewModel = ItemsListViewModel(provider: provider)
        let mockedCategoryFilter: CategoryFilter = CategoryFilter(itemCategory: ItemCategory.childcareArticles)

        // WHEN
        viewModel.toggleCategory(for: mockedCategoryFilter)
        
        // THEN
        XCTAssertFalse(mockedCategoryFilter.isVisible)
    }
}
