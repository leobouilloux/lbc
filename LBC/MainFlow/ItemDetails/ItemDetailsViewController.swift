//
//  ItemDetailsViewController.swift
//  LBC
//
//  Created by Leo Marcotte on 26/09/2020.
//  Copyright © 2020 Leo Marcotte. All rights reserved.
//

import UIKit

final class ItemDetailsViewController: BaseViewController {
    let viewModel: ItemDetailsViewModel

    private let scrollView: UIScrollView
    private let itemView: UIView
    private let itemPriceLabel: UILabel
    private let itemImageView: UIImageView
    private let itemCategoryTag: GradientTag
    private let itemTitleLabel: UILabel
    private let itemDescriptionLabel: UILabel
    private let itemCreationDateLabel: UILabel

    init(with viewModel: ItemDetailsViewModel) {
        self.viewModel = viewModel
        self.scrollView = UIScrollView()
        self.itemView = UIView()
        self.itemImageView = UIImageView()
        self.itemPriceLabel = UILabel()
        self.itemTitleLabel = UILabel()
        self.itemCategoryTag = GradientTag()
        self.itemDescriptionLabel = UILabel()
        self.itemCreationDateLabel = UILabel()

        super.init(nibName: nil, bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if let url = viewModel.imageURL {
            itemImageView.loadImage(at: url, contentMode: .scaleAspectFill)
        }
    }
}

private extension ItemDetailsViewController {
    /* View */
    func setupView() {
        view.backgroundColor = Style.backgroundColor

        setupScrollView()
    }

    func setupScrollView() {
        view.addSubview(scrollView)

        setupItemView()

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }

    func setupItemView() {
        itemView.backgroundColor = Style.backgroundColor
        scrollView.addSubview(itemView)

        setupItemImageView()
        setupItemTitleLabel()
        setupItemCategoryTag()
        setupItemDescriptionLabel()
        setupItemCreationDateLabel()

        itemView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            itemView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            itemView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            itemView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }

    func setupItemImageView() {
        itemImageView.backgroundColor = .lightGray
        itemImageView.clipsToBounds = true
        itemImageView.image = Assets.Icons.cameraOff
        itemImageView.tintColor = .white
        itemImageView.contentMode = .center
        itemView.addSubview(itemImageView)

        setupItemPriceLabel()

        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemImageView.heightAnchor.constraint(greaterThanOrEqualToConstant: 200),
            itemImageView.topAnchor.constraint(equalTo: itemView.topAnchor),
            itemImageView.leadingAnchor.constraint(equalTo: itemView.leadingAnchor),
            itemImageView.trailingAnchor.constraint(equalTo: itemView.trailingAnchor),
            itemImageView.widthAnchor.constraint(equalTo: itemView.widthAnchor)
        ])
    }

    func setupItemPriceLabel() {
        itemPriceLabel.text = " \(viewModel.price) "
        itemPriceLabel.font = .monospacedDigitSystemFont(ofSize: 22, weight: .bold)
        itemPriceLabel.backgroundColor = Style.backgroundColor.withAlphaComponent(0.4)
        itemImageView.addSubview(itemPriceLabel)

        itemPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemPriceLabel.trailingAnchor.constraint(equalTo: itemImageView.trailingAnchor),
            itemPriceLabel.bottomAnchor.constraint(equalTo: itemImageView.bottomAnchor)
        ])

        itemPriceLabel.layer.masksToBounds = true
        itemPriceLabel.layer.maskedCorners = [.layerMinXMinYCorner]
        itemPriceLabel.layer.cornerRadius = 4
    }

    func setupItemTitleLabel() {
        itemTitleLabel.text = viewModel.title
        itemTitleLabel.font = .boldSystemFont(ofSize: 20)
        itemTitleLabel.numberOfLines = 0
        itemView.addSubview(itemTitleLabel)

        itemTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemTitleLabel.topAnchor.constraint(equalTo: itemImageView.bottomAnchor, constant: 16),
            itemTitleLabel.leadingAnchor.constraint(equalTo: itemView.leadingAnchor, constant: 16),
            itemTitleLabel.trailingAnchor.constraint(equalTo: itemView.trailingAnchor, constant: -16)
        ])
    }

    func setupItemCategoryTag() {
        itemCategoryTag.label.text = viewModel.category.name
        itemCategoryTag.label.font = .boldSystemFont(ofSize: 16)
        itemCategoryTag.label.textColor = .white
        itemCategoryTag.gradientColors = viewModel.category.gradientColors

        view.addSubview(itemCategoryTag)

        itemCategoryTag.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemCategoryTag.topAnchor.constraint(equalTo: itemTitleLabel.bottomAnchor, constant: 16),
            itemCategoryTag.leadingAnchor.constraint(equalTo: itemView.leadingAnchor, constant: 16)
        ])
    }

    func setupItemDescriptionLabel() {
        itemDescriptionLabel.text = viewModel.description
        itemDescriptionLabel.font = .systemFont(ofSize: 16)
        itemDescriptionLabel.numberOfLines = 0
        itemView.addSubview(itemDescriptionLabel)

        itemDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemDescriptionLabel.topAnchor.constraint(equalTo: itemCategoryTag.bottomAnchor, constant: 16),
            itemDescriptionLabel.leadingAnchor.constraint(equalTo: itemView.leadingAnchor, constant: 16),
            itemDescriptionLabel.trailingAnchor.constraint(equalTo: itemView.trailingAnchor, constant: -16)
        ])
    }

    func setupItemCreationDateLabel() {
        itemCreationDateLabel.text = viewModel.creationDate
        itemCreationDateLabel.font = .italicSystemFont(ofSize: 14)
        itemCreationDateLabel.textColor = .systemGray
        itemView.addSubview(itemCreationDateLabel)

        itemCreationDateLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemCreationDateLabel.topAnchor.constraint(equalTo: itemDescriptionLabel.bottomAnchor, constant: 24),
            itemCreationDateLabel.bottomAnchor.constraint(equalTo: itemView.bottomAnchor, constant: -16),
            itemCreationDateLabel.leadingAnchor.constraint(equalTo: itemView.leadingAnchor, constant: 16),
            itemCreationDateLabel.trailingAnchor.constraint(equalTo: itemView.trailingAnchor, constant: -16)
        ])
    }
}
