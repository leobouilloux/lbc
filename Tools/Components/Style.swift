//
//  Style.swift
//  LBC
//
//  Created by Leo Marcotte on 24/09/2020.
//  Copyright © 2020 Leo Marcotte. All rights reserved.
//

import UIKit

enum Style {
    static var gradientViewColors: [CGColor] {
        if #available(iOS 13, *) {
            return [UIColor.systemBackground.withAlphaComponent(0).cgColor, UIColor.systemBackground.cgColor]
        } else {
            return [UIColor.white.withAlphaComponent(0).cgColor, UIColor.white.cgColor]
        }
    }
    
    static var backgroundColor: UIColor {
        if #available(iOS 13, *) {
            return .systemBackground
        } else {
            return .white
        }
    }
    
    static var tintColor: UIColor {
        if #available(iOS 13, *) {
            return .label
        } else {
            return .black
        }
    }
    
    static var textColor: UIColor {
        if #available(iOS 13, *) {
            return .label
        } else {
            return .black
        }
    }
    
    enum NavigationBar {
        static var tintColor: UIColor {
            if #available(iOS 13, *) {
                return .secondaryLabel
            } else {
                return .gray
            }
        }
        static var barTintColor: UIColor {
            if #available(iOS 13, *) {
                return .systemBackground
            } else {
                return .white
            }
        }
    }
    
    enum SnackBar {
        static var shadowColor: CGColor = UIColor.black.cgColor
        static var backgroundColor: UIColor = .white
        static var labelColor: UIColor = .black
    }
    
    enum Loader {
        static var backgroundColor: UIColor {
            if #available(iOS 13, *) {
                return .systemBackground
            } else {
                return .white
            }
        }

        static var tintColor: UIColor {
            if #available(iOS 13, *) {
                return .secondaryLabel
            } else {
                return .gray
            }
        }
    }
}
