//
//  CategoryTableViewCellViewModel.swift
//  LBC
//
//  Created by Leo Marcotte on 29/09/2020.
//  Copyright © 2020 Leo Marcotte. All rights reserved.
//

import UIKit

final class CategoryTableViewCellViewModel {
    let title: String
    let gradientColors: (UIColor, UIColor)

    init(filter: CategoryFilter) {
        self.title = filter.itemCategory.name
        if filter.isVisible {
            self.gradientColors = filter.itemCategory.gradientColors
        } else {
            self.gradientColors = (.darkGray, .lightGray)
        }
    }
}
