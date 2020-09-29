//
//  MainFactory.swift
//  LBC
//
//  Created by Leo Marcotte on 26/09/2020.
//  Copyright © 2020 Leo Marcotte. All rights reserved.
//

final class MainFactory {
    func makeItemsListPresentable(with viewModel: ItemsListViewModel) -> Presentable {
        return ItemsListViewController(with: viewModel)
    }
    
    func makeItemDetailsPresentable(with viewModel: ItemDetailsViewModel) -> Presentable {
        return ItemDetailsViewController(with: viewModel)
    }
    
    func makeCategoriesFilterPresentable(with viewModel: CategoriesFilterViewModel) -> Presentable {
        return CategoriesFilterViewController(with: viewModel)
    }
}
