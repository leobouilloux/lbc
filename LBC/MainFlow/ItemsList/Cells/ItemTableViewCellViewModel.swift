//
//  ItemTableViewCellViewModel.swift
//  LBC
//
//  Created by Leo Marcotte on 25/09/2020.
//  Copyright © 2020 Leo Marcotte. All rights reserved.
//

import UIKit

final class ItemTableViewCellViewModel: ItemTableViewCellViewModelInterface {
    var image: UIImage
    var imageURL: URL?

    let title: String
    let category: ItemCategory
    let price: String

    init(item: Item) {
        self.title = item.title
        self.category = item.category
        self.price = String(format: "%.2f €", item.price)
        self.image = UIImage()

        if let imageURL = item.imagesURL.small {
            self.imageURL = imageURL
        }
    }
}
