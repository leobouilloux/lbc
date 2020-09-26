//
//  ItemDetailsViewController.swift
//  LBC
//
//  Created by Leo Marcotte on 26/09/2020.
//  Copyright © 2020 Leo Marcotte. All rights reserved.
//

import Foundation

final class ItemDetailsViewModel {
    init(with item: Item) {
        
    }
}

final class ItemDetailsViewController: BaseViewController {
    let viewModel: ItemDetailsViewModel
    
    init(with viewModel: ItemDetailsViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
}

private extension ItemDetailsViewController {
    /******************************************/
    /* View */
    func setupView() {
        view.backgroundColor = .green
    }
}
