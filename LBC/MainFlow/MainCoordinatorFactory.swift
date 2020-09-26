//
//  MainCoordinatorFactory.swift
//  LBC
//
//  Created by Leo Marcotte on 26/09/2020.
//  Copyright © 2020 Leo Marcotte. All rights reserved.
//

extension CoordinatorFactory {
    func makeMainCoordinator(
        with provider: Provider,
        navController: NavigationController? = nil,
        coordinatorFactory: CoordinatorFactory = CoordinatorFactory()
        ) -> MainCoordinator {
        let coordinator = MainCoordinator(router: router(navController),
                                               factory: MainFactory(),
                                               coordinatorFactory: coordinatorFactory,
                                               provider: provider)
        return coordinator
    }
}
