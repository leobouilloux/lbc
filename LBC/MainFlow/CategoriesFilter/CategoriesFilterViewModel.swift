//
//  CategoriesFilterViewModel.swift
//  LBC
//
//  Created by Leo Marcotte on 29/09/2020.
//  Copyright © 2020 Leo Marcotte. All rights reserved.
//

final class CategoriesFilterViewModel {
    let filters: [CategoryFilter]
    let activeCategoriesHeader: String
    let hiddenCategoriesHeader: String

    var output: CategoriesFilterOutput?

    init(filters: [CategoryFilter]) {
        self.filters = filters
        self.activeCategoriesHeader = Loc.CategoriesFilter.visibleCategoriesHeader
        self.hiddenCategoriesHeader = Loc.CategoriesFilter.hiddenCategoriesHeader
    }

    func toggleCategory(for category: CategoryFilter) {
        category.isVisible.toggle()
    }
}
