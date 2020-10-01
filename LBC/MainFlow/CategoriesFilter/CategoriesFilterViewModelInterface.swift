//
//  CategoriesFilterViewModelInterface.swift
//  LBC
//
//  Created by Leo Marcotte on 01/10/2020.
//  Copyright © 2020 Leo Marcotte. All rights reserved.
//

protocol CategoriesFilterViewModelInterface {
    var filters: [CategoryFilter] { get }
    var activeCategoriesHeader: String { get }
    var hiddenCategoriesHeader: String { get }

    var output: CategoriesFilterOutput? { get set }

    func toggleCategory(for category: CategoryFilter)
}
