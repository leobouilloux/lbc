//
//  UIViewController+Extension.swift
//  LBC
//
//  Created by Leo Marcotte on 24/09/2020.
//  Copyright © 2020 Leo Marcotte. All rights reserved.
//

import UIKit

public extension UIViewController {
    func setStatusBarStyle(with style: UIStatusBarStyle, animated: Bool) {
        UIApplication.shared.setStatusBarStyle(style, animated: animated)
    }

    func setStatusBarStyle(with style: UIStatusBarStyle) {
        UIApplication.shared.statusBarStyle = style
    }

    func setStatusBarVisibility(isHidden: Bool, animation: UIStatusBarAnimation) {
        UIApplication.shared.setStatusBarHidden(isHidden, with: animation)
    }

    func setStatusBarVisibility(isHidden: Bool) {
        UIApplication.shared.isStatusBarHidden = isHidden
    }

    var isModal: Bool {
        let presentingIsModal = presentingViewController != nil
        let presentingIsNavigation = navigationController?.presentingViewController?.presentedViewController == navigationController
        let presentingIsTabBar = tabBarController?.presentingViewController is UITabBarController

        return presentingIsModal || presentingIsNavigation || presentingIsTabBar
    }
}
