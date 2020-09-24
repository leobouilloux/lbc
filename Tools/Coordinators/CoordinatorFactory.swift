//
//  CoordinatorFactory.swift
//  LBC
//
//  Created by Leo Marcotte on 24/09/2020.
//  Copyright © 2020 Leo Marcotte. All rights reserved.
//


import UIKit

public class CoordinatorFactory {
    public init() {}

    public func router(_ navController: UINavigationController?) -> Router {
        return RouterImp(rootController: navigationController(navController))
    }

    public func navigationController(_ navController: UINavigationController?) -> UINavigationController {
        return navController ?? UINavigationController(rootViewController: UIViewController())
    }
}
