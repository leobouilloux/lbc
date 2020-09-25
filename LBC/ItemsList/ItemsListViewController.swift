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
        self.viewModel.delegate = self
    }

    /******************************************/
    /* View */
    private lazy var tableView: UITableView = setupTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        setupView()
        viewModel.fetchItems()
    }
}

extension ItemsListViewController {
    /******************************************/
    /* View */
    func setupView() {
        setupTableView()
    }
    
    func setupTableView() -> UITableView {
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
        return tableView
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
        let cell = ItemTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: UUID().uuidString)
        let cellViewModel = ItemTableViewCellViewModel(item: viewModel.items[indexPath.row])
        cell.setup(with: cellViewModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 104
    }
}

extension ItemsListViewController: ItemListViewModelDelegate {
    func itemsLoaded() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func errorOccured() {
        
    }
}
