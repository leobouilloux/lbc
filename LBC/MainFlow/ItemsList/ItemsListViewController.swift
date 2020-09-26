//
//  ItemsListViewController.swift
//  LBC
//
//  Created by Leo Marcotte on 24/09/2020.
//  Copyright © 2020 Leo Marcotte. All rights reserved.
//

import UIKit

final class ItemsListViewController: BaseViewController {
    private let viewModel: ItemsListViewModel
    
    private let tableView: UITableView
    
    public init(with viewModel: ItemsListViewModel) {
        self.viewModel = viewModel
        self.tableView = UITableView()
        
        super.init(nibName: nil, bundle: ItemsListViewController.bundle)
        
        self.viewModel.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupView()
    
        self.showLoader { [weak self] in
            self?.viewModel.fetchItems()
        }
    }
}

private extension ItemsListViewController {
    /******************************************/
    /* NavigationBar */
    func setupNavigationBar() {
        setupNavigationBarTitle()
        setupFilterBarButton()
    }
    
    func setupNavigationBarTitle() {
        navigationItem.title = "Le bon coin"
    }
    
    func setupFilterBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(named: "filter"),
            style: .plain,
            target: self,
            action: #selector(filterBarButtonPressed(sender:))
        )
    }
    
    /******************************************/
    /* Actions */
    @objc func filterBarButtonPressed(sender: UIBarButtonItem) {
        let alertController = UIAlertController(
            title: "Filter categories",
            message: "Select categories you want to display, blue options are visible, red options are hidden",
            preferredStyle: .actionSheet)
        viewModel.filters.forEach { (categoryFilter) in
            let alertActionStyle: UIAlertAction.Style = categoryFilter.isVisible ? .default : .destructive
            
            let action = UIAlertAction(
                title: categoryFilter.itemCategory.name,
                style: alertActionStyle) { [weak self] _ in
                    self?.viewModel.toggleCategory(for: categoryFilter)
            }
            alertController.addAction(action)
        }
        present(alertController, animated: true)
    }
    
    /******************************************/
    /* View */
    func setupView() {
        setupTableView()
    }
    
    func setupTableView() {
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
        let item = viewModel.items[indexPath.row]
        viewModel.output?.showItemDetails(item: item)
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

extension ItemsListViewController: ItemsListViewModelDelegate {
    func itemsLoaded() {
        self.hideLoader { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    func errorOccured() {
        self.hideLoader { [weak self] in
            self?.snackBarController.error(message: "Couldn't load data")
        }
    }
}
