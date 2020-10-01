//
//  ItemTableViewCellViewModelInterface.swift
//  LBC
//
//  Created by Leo Marcotte on 01/10/2020.
//  Copyright © 2020 Leo Marcotte. All rights reserved.
//

import UIKit

protocol ItemTableViewCellViewModelInterface {
    var image: UIImage { get set }
    var imageURL: URL? { get set }

    var title: String { get }
    var category: ItemCategory { get }
    var price: String { get }
}
