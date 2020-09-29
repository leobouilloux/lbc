//
//  CategoriesFilterViewController.swift
//  LBC
//
//  Created by Leo Marcotte on 29/09/2020.
//  Copyright © 2020 Leo Marcotte. All rights reserved.
//

import UIKit

final class CategoriesFilterViewController: BaseViewController {
    let viewModel: CategoriesFilterViewModel
    
    private let tableView: UITableView
    private let confirmButton: UIButton
    
    init(with viewModel: CategoriesFilterViewModel) {
        self.viewModel = viewModel
        
        self.tableView = UITableView()
        self.confirmButton = UIButton()
        
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
}

private extension CategoriesFilterViewController {
    /******************************************/
    /* View */
    func setupView() {
        view.backgroundColor = Style.backgroundColor
        setupConfirmButton()
        setupTableView()
    }
    
    func setupConfirmButton() {
        confirmButton.backgroundColor = .systemBlue
        confirmButton.tintColor = .white
        confirmButton.titleLabel?.font = .boldSystemFont(ofSize: 24)
        confirmButton.addTarget(self, action: #selector(confirmButtonPressed(sender:)), for: .touchUpInside)
        confirmButton.setTitle(Loc.CategoriesFilter.confirmButtonTitle, for: .normal)
        view.addSubview(confirmButton)
        
        confirmButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            confirmButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            confirmButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            confirmButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            confirmButton.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        confirmButton.layer.masksToBounds = true
        confirmButton.layer.cornerRadius = 4
    }
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.register(CategoryTableViewCell.self, forCellReuseIdentifier: CategoryTableViewCell.identifier)
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: confirmButton.topAnchor, constant: -16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    /******************************************/
    /* Actions */
    @objc func confirmButtonPressed(sender: UIButton) {
        dismiss(animated: true, completion: { [weak self] in
            guard let self = self else { return }
            self.viewModel.output?.updateFilters(filters: self.viewModel.filters)
        })
    }
}

extension CategoriesFilterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let categoryFilter = viewModel.filters.filter({ $0.isVisible })[indexPath.row]
            viewModel.toggleCategory(for: categoryFilter)
        } else if indexPath.section == 1 {
            let categoryFilter = viewModel.filters.filter({ !$0.isVisible })[indexPath.row]
            viewModel.toggleCategory(for: categoryFilter)
        }
        self.tableView.reloadData()
    }
}

extension CategoriesFilterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return Loc.CategoriesFilter.visibleCategoriesHeader
        } else if section == 1 {
            return Loc.CategoriesFilter.hiddenCategoriesHeader
        } else {
            return nil
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return viewModel.filters.filter({ $0.isVisible }).count
        } else if section == 1 {
            return viewModel.filters.filter({ !$0.isVisible }).count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = CategoryTableViewCell()

        var filter: CategoryFilter?
        if indexPath.section == 0 {
            filter = viewModel.filters.filter({ $0.isVisible })[indexPath.row]
        } else if indexPath.section == 1 {
            filter = viewModel.filters.filter({ !$0.isVisible })[indexPath.row]
        }
        
        guard let rowFilter = filter else { return UITableViewCell() }

        let cellViewModel = CategoryTableViewCellViewModel(filter: rowFilter)
        cell.setup(with: cellViewModel)
        return cell
    }
}
