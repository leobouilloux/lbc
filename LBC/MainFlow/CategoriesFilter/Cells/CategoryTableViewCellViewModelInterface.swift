//
//  CategoryTableViewCellViewModelInterface.swift
//  LBC
//
//  Created by Leo Marcotte on 01/10/2020.
//  Copyright © 2020 Leo Marcotte. All rights reserved.
//

import UIKit

protocol CategoryTableViewCellViewModelInterface {
    var title: String { get }
    var gradientColors: (UIColor, UIColor) { get }
}
