//
//  ItemsListViewModelInterface.swift
//  LBC
//
//  Created by Leo Marcotte on 01/10/2020.
//  Copyright © 2020 Leo Marcotte. All rights reserved.
//

protocol ItemsListViewModelInterface {
    var provider: Provider { get }
    var items: [Item] { get set }
    var filters: [CategoryFilter] { get }

    var delegate: ItemsListViewModelDelegate? { get }
    var output: ItemsListOutput? { get set }

    func setupFilters()
    func setFilters(with filters: [CategoryFilter])
    func toggleCategory(for category: CategoryFilter)
    func fetchItems()
    func processItems(items: [Item])

    func setDelegate(with delegate: ItemsListViewModelDelegate)
}
