//
//  NetworkError.swift
//  LBC
//
//  Created by Leo Marcotte on 01/10/2020.
//  Copyright © 2020 Leo Marcotte. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case jsonDecodeFailed
    case errorReceived
    case noDataReceived

    var userFriendlyErrorMessage: String {
        switch self {
        case .jsonDecodeFailed: return Loc.Error.jsonDecodeFailed
        case .errorReceived: return Loc.Error.errorReceived
        case  .noDataReceived: return Loc.Error.noDataReceived
        }
    }
}
