//
//  ItemsListViewModel.swift
//  LBC
//
//  Created by Leo Marcotte on 24/09/2020.
//  Copyright © 2020 Leo Marcotte. All rights reserved.
//

class ItemsListViewModel {
    let provider: Provider
    var items = [Item]()
    var delegate: ItemListViewModelDelegate?
    
    init(provider: Provider) {
        self.provider = provider
    }

    func fetchItems() {
        provider.fetchData { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(items):
                self.items = items
                self.delegate?.itemsLoaded()
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}

protocol ItemListViewModelDelegate {
    func itemsLoaded()
    func errorOccured()
}
