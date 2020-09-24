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
//        case .error:    return UIImage(systemName: "xmark.circle.fill")!
//        case .warning:  return UIImage(systemName: "exclamationmark.triangle.fill")!
//        case .success:  return UIImage(systemName: "checkmark.circle.fill")!
//        case .info:     return UIImage(systemName: "info.circle.fill")!
        default: return UIImage()
        }
    }
}
