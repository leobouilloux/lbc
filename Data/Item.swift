//
//  Item.swift
//  LBC
//
//  Created by Leo Marcotte on 24/09/2020.
//  Copyright © 2020 Leo Marcotte. All rights reserved.
//

import Foundation

struct Item: Codable {
    var id: Int
    var category: ItemCategory
    var title: String
    var description: String
    var price: Double
    var imagesURL: ItemImagesURL
    var creationDate: Date
    var isUrgent: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case category = "category_id"
        case title
        case description
        case price
        case imagesURL = "images_url"
        case creationDate = "creation_date"
        case isUrgent = "is_urgent"
    }
}
