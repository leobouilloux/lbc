//
//  ItemsListOutput.swift
//  LBC
//
//  Created by Leo Marcotte on 25/09/2020.
//  Copyright © 2020 Leo Marcotte. All rights reserved.
//

protocol ItemsListOutput {
    func showItemDetails(item: Item)
    func showCategoriesFilter(filters: [CategoryFilter])
}
