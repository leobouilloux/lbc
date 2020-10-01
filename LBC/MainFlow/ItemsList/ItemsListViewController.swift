//
//  ItemsListViewController.swift
//  LBC
//
//  Created by Leo Marcotte on 24/09/2020.
//  Copyright © 2020 Leo Marcotte. All rights reserved.
//

import UIKit

final class ItemsListViewController: BaseViewController {
    let viewModel: ItemsListViewModel

    private let tableView: UITableView
    private let refreshControl: UIRefreshControl
    private let gradientView: UIView

    public init(with viewModel: ItemsListViewModel) {
        self.viewModel = viewModel
        self.tableView = UITableView()
        self.refreshControl = UIRefreshControl()
        self.gradientView = UIView()

        super.init(nibName: nil, bundle: ItemsListViewController.bundle)

        self.viewModel.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupView()

        viewModel.fetchItems()
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if #available(iOS 13.0, *) { // Detect dark mode change to reapply the correct gradient
            if self.traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
                gradientView.layer.sublayers?.removeAll()

                let gradientLayer = CAGradientLayer()
                gradientLayer.colors = Style.gradientViewColors
                gradientLayer.locations =  [0.0, 1.0]
                gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
                gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
                gradientLayer.frame.size = CGSize(width: view.bounds.width, height: 200)
                gradientView.layer.insertSublayer(gradientLayer, at: 0)
            }
        }
    }
}

private extension ItemsListViewController {
    /* NavigationBar */
    func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = Style.NavigationBar.tintColor
        navigationController?.navigationBar.barTintColor = Style.NavigationBar.barTintColor

        setupNavigationBarTitle()
        setupFilterBarButton()
    }

    func setupNavigationBarTitle() {
        navigationItem.title = "Le bon coin"
    }

    func setupFilterBarButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: Assets.Icons.filter,
            style: .plain,
            target: self,
            action: #selector(filterBarButtonPressed(sender:))
        )
    }

    /* View */
    func setupView() {
        setupTableView()
        setupGradientView()
    }

    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 200, right: 0)
        tableView.register(ItemTableViewCell.self, forCellReuseIdentifier: ItemTableViewCell.identifier)

        view.addSubview(tableView)

        setupRefreshControl()

        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(refreshTableView(sender:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }

    func setupGradientView() {
        gradientView.isUserInteractionEnabled = false
        view.addSubview(gradientView)

        gradientView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            gradientView.heightAnchor.constraint(equalToConstant: 200),
            gradientView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            gradientView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = Style.gradientViewColors
        gradientLayer.locations =  [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer.frame.size = CGSize(width: view.bounds.width, height: 200)
        gradientView.layer.insertSublayer(gradientLayer, at: 0)
    }

    /* Actions */
    @objc func filterBarButtonPressed(sender: UIBarButtonItem) {
        viewModel.output?.showCategoriesFilter(filters: viewModel.filters)
    }

    @objc func refreshTableView(sender: UIRefreshControl) {
        viewModel.fetchItems()
    }
}

extension ItemsListViewController: UITableViewDelegate {
    /* UITableViewDelegate */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = viewModel.items[safeIndex: indexPath.row] else { return }
        viewModel.output?.showItemDetails(item: item)
    }
}

extension ItemsListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.items.isEmpty {
            tableView.separatorStyle = .none
        } else {
            tableView.separatorStyle = .singleLine
        }
        return viewModel.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let item = viewModel.items[safeIndex: indexPath.row] {
            let cell = ItemTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: UUID().uuidString)
            let cellViewModel = ItemTableViewCellViewModel(item: item)

            cell.setup(with: cellViewModel)
            return cell
        } else {
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 104
    }
}

extension ItemsListViewController: ItemsListViewModelDelegate {
    func dataIsLoading() {
        showLoader { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.refreshControl?.endRefreshing()
            }
        }
    }

    func itemsLoaded() {
        self.hideLoader { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }

    func errorOccured(error: NetworkError) {
        self.hideLoader { [weak self] in
            DispatchQueue.main.async {
                self?.snackBarController.error(message: error.userFriendlyErrorMessage)
            }
        }
    }
}
