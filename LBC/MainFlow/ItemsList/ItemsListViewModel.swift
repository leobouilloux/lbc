//
//  ItemsListViewModel.swift
//  LBC
//
//  Created by Leo Marcotte on 24/09/2020.
//  Copyright © 2020 Leo Marcotte. All rights reserved.
//

final class ItemsListViewModel: ItemsListViewModelInterface {
    let provider: Provider
    var items = [Item]()
    var filters = [CategoryFilter]()

    weak var delegate: ItemsListViewModelDelegate?
    var output: ItemsListOutput?

    init(provider: Provider) {
        self.provider = provider

        setupFilters()
    }

    func setupFilters() {
        ItemCategory.allCases.forEach { itemCategory in
            filters.append(CategoryFilter(itemCategory: itemCategory))
        }
    }

    func setFilters(with filters: [CategoryFilter]) {
        self.filters = filters
    }

    func setDelegate(with delegate: ItemsListViewModelDelegate) {
        self.delegate = delegate
    }

    func toggleCategory(for category: CategoryFilter) {
        category.isVisible.toggle()
        fetchItems()
    }

    func fetchItems() {
        delegate?.dataIsLoading()
        provider.fetchData { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(items):
                self.processItems(items: items)
            case let .failure(error):
                print(error.localizedDescription)
                if let error = error as? NetworkError {
                    self.delegate?.errorOccured(error: error)
                }
            }
        }
    }

    func processItems(items: [Item]) {
        let filteredItems = items.filter { item -> Bool in
            filters.first(where: { $0.itemCategory == item.category })?.isVisible ?? false
        }
        self.items = filteredItems
            .sorted(by: { $0.creationDate > $1.creationDate })
            .sorted(by: { $0.isUrgent && !$1.isUrgent })
        delegate?.itemsLoaded()
    }
}

protocol ItemsListViewModelDelegate: AnyObject {
    func dataIsLoading()
    func itemsLoaded()
    func errorOccured(error: NetworkError)
}
