//
//  SplashScreenCoordinator.swift
//  LBC
//
//  Created by Leo Marcotte on 26/09/2020.
//  Copyright © 2020 Leo Marcotte. All rights reserved.
//

final class SplashScreenCoordinator: BaseCoordinator {
    private let factory: SplashScreenFactory
    private let coordinatorFactory: CoordinatorFactory
    private let provider: Provider

    var output: SplashScreenCoordinatorOutput?

    init(router: Router, factory: SplashScreenFactory, coordinatorFactory: CoordinatorFactory, provider: Provider) {
        self.factory = factory
        self.coordinatorFactory = coordinatorFactory
        self.provider = provider
        super.init(router: router)
    }

    override func start(with option: DeepLinkOption? = nil, presentationType: PresentationType = .root) {
        setupRoot(presentationType: presentationType)
    }
}

private extension SplashScreenCoordinator {
    func setupRoot(presentationType: PresentationType) {
        let viewModel = SplashScreenViewModel(with: provider)
        viewModel.output = self
        
        let splashScreenPresentable = factory.makeSplashScreenPresentable(with: viewModel)
        router.navigate(to: splashScreenPresentable, with: presentationType)
    }
}

/******************************************/
/* Output */
extension SplashScreenCoordinator: SplashScreenOutput {
    func didFinishLoading() {
        output?.didFinishLoading(coordinator: self)
    }
}
