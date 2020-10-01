//
//  NSObject+Extension.swift
//  LBC
//
//  Created by Leo Marcotte on 24/09/2020.
//  Copyright © 2020 Leo Marcotte. All rights reserved.
//

import Foundation

public extension NSObject {
    var nameOfClass: String {
        return NSStringFromClass(type(of: self)).components(separatedBy: ".").last ?? ""
    }

    class var nameOfClass: String {
        return NSStringFromClass(self).components(separatedBy: ".").last ?? ""
    }

    class var bundle: Bundle {
        return Bundle(for: self)
    }
}
