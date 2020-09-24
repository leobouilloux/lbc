//
//  ApplicationCoordinator.swift
//  LBC
//
//  Created by Leo Marcotte on 24/09/2020.
//  Copyright © 2020 Leo Marcotte. All rights reserved.
//

import UIKit

final class ApplicationCoordinator: Coordinator {
    var window: UIWindow
    var childCoordinators = [Coordinator]()
    private let coordinatorFactory: CoordinatorFactory
    private let provider: Provider
    
    
    init(window: UIWindow, coordinatorFactory: CoordinatorFactory, provider: Provider) {
        self.coordinatorFactory = coordinatorFactory
        self.window = window
        self.provider = provider
    }
    
    func start(with option: DeepLinkOption? = nil, presentationType: PresentationType = .root) {
        if let option = option, !childCoordinators.isEmpty {
            switch option {
            default: childCoordinators.forEach { $0.start(with: option, presentationType: .root) }
            }
        } else {
            runMainFlow(presentationType: presentationType)
//            runSplashScreenFlow()
        }
    }
    
//    private func runSplashScreenFlow(with option: DeepLinkOption? = nil) {
//        let coordinator = coordinatorFactory.makeSplashScreenCoordinator(with: provider)
//        coordinator.output.finishFlowAction = {
//            self?.removeDependency(coordinator)
//            self?.runMainFlow()
//
//            }
//        addDependency(coordinator)
//        coordinator.start(with: option)
//
//        window.rootViewController = coordinator.router.toPresent()
//    }
    
    private func runMainFlow(with option: DeepLinkOption? = nil, presentationType: PresentationType) {
        window.rootViewController = ItemsListViewController(with: ItemsListViewModel())
    }
//        let coordinator = TabbarFactory().makeTabbarCoordinator(provider: provider)
//        addDependency(coordinator)
//        coordinator.start(with: option)
//
//        window.rootViewController = coordinator.tabbarRouter.toPresent()
}
