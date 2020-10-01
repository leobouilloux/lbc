//
//  ItemDetailsViewModel.swift
//  LBC
//
//  Created by Leo Marcotte on 27/09/2020.
//  Copyright © 2020 Leo Marcotte. All rights reserved.
//

import Foundation

final class ItemDetailsViewModel {
    let imageURL: URL?
    let title: String
    let price: String
    let category: ItemCategory
    let description: String
    let creationDate: String

    init(with item: Item) {
        self.imageURL = item.imagesURL.thumb
        self.title = item.title
        self.price = String(format: "%.2f €", item.price)
        self.category = item.category
        self.description = item.description

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE d MMM yyyy HH:mm:ss"
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone.current
        self.creationDate = dateFormatter.string(from: item.creationDate)
    }
}
