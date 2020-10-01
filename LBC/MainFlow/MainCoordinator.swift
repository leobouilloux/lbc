//
//  MainCoordinator.swift
//  LBC
//
//  Created by Leo Marcotte on 26/09/2020.
//  Copyright © 2020 Leo Marcotte. All rights reserved.
//

final class MainCoordinator: BaseCoordinator {
    private let factory: MainFactory
    private let coordinatorFactory: CoordinatorFactory
    private let provider: Provider

    init(router: Router, factory: MainFactory, coordinatorFactory: CoordinatorFactory, provider: Provider) {
        self.factory = factory
        self.coordinatorFactory = coordinatorFactory
        self.provider = provider
        super.init(router: router)
    }

    override func start(with option: DeepLinkOption? = nil, presentationType: PresentationType = .root) {
        setupRoot(presentationType: presentationType)
    }
}

private extension MainCoordinator {
    func setupRoot(presentationType: PresentationType) {
        let viewModel = ItemsListViewModel(provider: provider)
        viewModel.output = self

        let presentable = factory.makeItemsListPresentable(with: viewModel)
        router.navigate(to: presentable, with: presentationType)
    }

    func showItemDetails(item: Item, presentationType: PresentationType) {
        let viewModel = ItemDetailsViewModel(with: item)

        let presentable = factory.makeItemDetailsPresentable(with: viewModel)
        router.navigate(to: presentable, with: presentationType)
    }

    func showCategoriesFilter(filters: [CategoryFilter], presentationType: PresentationType) {
        let viewModel = CategoriesFilterViewModel(filters: filters)
        viewModel.output = self

        let presentable = factory.makeCategoriesFilterPresentable(with: viewModel)
        router.navigate(to: presentable, with: presentationType)
    }
}

/* Outputs */
extension MainCoordinator: ItemsListOutput {
    func showItemDetails(item: Item) {
        showItemDetails(item: item, presentationType: .push)
    }

    func showCategoriesFilter(filters: [CategoryFilter]) {
        showCategoriesFilter(filters: filters, presentationType: .present)
    }
}

extension MainCoordinator: CategoriesFilterOutput {
    func updateFilters(filters: [CategoryFilter]) {
        if let navController = router.toPresent() as? NavigationController,
            let rootController = navController.viewControllers.first as? ItemsListViewController {
            rootController.viewModel.filters = filters
            rootController.viewModel.fetchItems()
        }
    }
}
