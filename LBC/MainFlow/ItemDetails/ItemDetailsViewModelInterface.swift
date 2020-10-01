//
//  ItemDetailsViewModelInterface.swift
//  LBC
//
//  Created by Leo Marcotte on 01/10/2020.
//  Copyright © 2020 Leo Marcotte. All rights reserved.
//

import Foundation

protocol ItemDetailsViewModelInterface {
    var imageURL: URL? { get }
    var title: String { get }
    var price: String { get }
    var category: ItemCategory { get }
    var description: String { get }
    var creationDate: String { get }
}
