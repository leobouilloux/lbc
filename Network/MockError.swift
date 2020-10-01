//
//  MockError.swift
//  LBC
//
//  Created by Leo Marcotte on 01/10/2020.
//  Copyright © 2020 Leo Marcotte. All rights reserved.
//

import Foundation

enum MockError: Error {
    case deserializationFailed
    case cannotReadFile
}
