//
//  ItemImagesURL.swift
//  LBC
//
//  Created by Leo Marcotte on 25/09/2020.
//  Copyright © 2020 Leo Marcotte. All rights reserved.
//

import Foundation

struct ItemImagesURL: Codable {
    var small: URL?
    var thumb: URL?

    enum CodingKeys: String, CodingKey {
        case small
        case thumb
    }
}
