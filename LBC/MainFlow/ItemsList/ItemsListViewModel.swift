//
//  ItemsListViewModel.swift
//  LBC
//
//  Created by Leo Marcotte on 24/09/2020.
//  Copyright © 2020 Leo Marcotte. All rights reserved.
//

final class ItemsListViewModel {
    let provider: Provider
    var items = [Item]()
    var delegate: ItemsListViewModelDelegate?
    var output: ItemsListOutput?
    
    var filters = [CategoryFilter]()
    
    init(provider: Provider) {
        self.provider = provider
        
        setupFilters()
    }
    
    func setupFilters() {
        ItemCategory.allCases.forEach { itemCategory in
            filters.append(CategoryFilter(itemCategory: itemCategory))
        }
    }
    
    func toggleCategory(for category: CategoryFilter) {
        category.isVisible.toggle()
        fetchItems()
    }
    
    func fetchItems() {
        provider.fetchData { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(items):
                self.processItems(items: items)
            case let .failure(error):
                print(error.localizedDescription)
                self.delegate?.errorOccured()
            }
        }
    }
    
    func processItems(items: [Item]) {
        let filteredItems = items.filter { item -> Bool in
            filters.first(where: { $0.itemCategory == item.category})?.isVisible ?? false
        }
        self.items = filteredItems
            .sorted(by: { $0.creationDate > $1.creationDate })
            .sorted(by: { $0.isUrgent && !$1.isUrgent })
        self.delegate?.itemsLoaded()
    }
}

protocol ItemsListViewModelDelegate {
    func itemsLoaded()
    func errorOccured()
}
