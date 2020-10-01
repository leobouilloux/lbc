//
//  Assets.swift
//  LBC
//
//  Created by Leo Marcotte on 01/10/2020.
//  Copyright © 2020 Leo Marcotte. All rights reserved.
//

import UIKit

enum Assets {
    static var avatar = UIImage(named: "avatar") ?? UIImage()
    static var logo = UIImage(named: "leboncoin-logo") ?? UIImage()
    enum Icons {
        static var error = UIImage(named: "error") ?? UIImage()
        static var warning = UIImage(named: "warning") ?? UIImage()
        static var success = UIImage(named: "success") ?? UIImage()
        static var info = UIImage(named: "info") ?? UIImage()
        static var filter = UIImage(named: "filter") ?? UIImage()
        static var cameraOff = UIImage(named: "camera-off") ?? UIImage()
        static var chevronLeft = UIImage(named: "chevron-left") ?? UIImage()
        static var close = UIImage(named: "close") ?? UIImage()
    }
}
