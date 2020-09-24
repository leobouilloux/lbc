//
//  ItemsListViewController.swift
//  LBC
//
//  Created by Leo Marcotte on 24/09/2020.
//  Copyright © 2020 Leo Marcotte. All rights reserved.
//

import UIKit

class ItemsListViewController: BaseViewController {
    private let viewModel: ItemsListViewModel
    
    public init(with viewModel: ItemsListViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: ItemsListViewController.bundle)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
}

extension ItemsListViewController {
    /******************************************/
    /* View */
    func setupView() {
        setupTableView()
    }
    
    func setupTableView() {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

extension ItemsListViewController: UITableViewDelegate {
    /******************************************/
    /* UITableViewDelegate */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension ItemsListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return ItemTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: UUID().uuidString)
    }
}
