//
//  MainFactory.swift
//  LBC
//
//  Created by Leo Marcotte on 26/09/2020.
//  Copyright © 2020 Leo Marcotte. All rights reserved.
//

final class MainFactory {
    func makeItemsListPresentable(with viewModel: ItemsListViewModelInterface) -> Presentable {
        return ItemsListViewController(with: viewModel)
    }

    func makeItemDetailsPresentable(with viewModel: ItemDetailsViewModelInterface) -> Presentable {
        return ItemDetailsViewController(with: viewModel)
    }

    func makeCategoriesFilterPresentable(with viewModel: CategoriesFilterViewModelInterface) -> Presentable {
        return CategoriesFilterViewController(with: viewModel)
    }
}
