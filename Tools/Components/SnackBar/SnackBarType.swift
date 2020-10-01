//
//  SnackBarType.swift
//  LBC
//
//  Created by Leo Marcotte on 24/09/2020.
//  Copyright © 2020 Leo Marcotte. All rights reserved.
//

import UIKit

public enum SnackBarType {
    case error
    case warning
    case success
    case info

    public var backgroundColor: UIColor {
        return Style.SnackBar.backgroundColor
    }

    public var imageColor: UIColor {
        switch self {
        case .error:    return .systemRed
        case .warning:  return .systemYellow
        case .success:  return .systemGreen
        case .info:     return .systemBlue
        }
    }

    public var textColor: UIColor {
        return Style.SnackBar.labelColor
    }

    public var image: UIImage { //TODO: Put real images here
        switch self {
        case .error:    return Assets.Icons.error
        case .warning:  return Assets.Icons.warning
        case .success:  return Assets.Icons.success
        case .info:     return Assets.Icons.info
        }
    }
}
