//
//  CategoryFilter.swift
//  LBC
//
//  Created by Leo Marcotte on 29/09/2020.
//  Copyright © 2020 Leo Marcotte. All rights reserved.
//

class CategoryFilter {
    let itemCategory: ItemCategory
    var isVisible: Bool = true
    
    init(itemCategory: ItemCategory) {
        self.itemCategory = itemCategory
    }
}
