//
//  ItemTableViewCell.swift
//  LBC
//
//  Created by Leo Marcotte on 24/09/2020.
//  Copyright © 2020 Leo Marcotte. All rights reserved.
//

import UIKit

final class ItemTableViewCell: UITableViewCell {
    let itemImageView = UIImageView()
    let titleLabel = UILabel()
    let categoryTag = GradientTag()
    let priceLabel = UILabel()
    
    var viewModel: ItemTableViewCellViewModel?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        selectionStyle = .none
    }
    
    func setup(with viewModel: ItemTableViewCellViewModel) {
        self.viewModel = viewModel
        
        setupView(with: viewModel)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        itemImageView.cancelImageLoad()
    }
}

private extension ItemTableViewCell {
    /******************************************/
    /* View */
    func setupView(with viewModel: ItemTableViewCellViewModel) {
        setupItemImage(with: viewModel)
        setupTitleLabel(with: viewModel)
        setupCategoryLabel(with: viewModel)
        setupPriceLabel(with: viewModel)
    }
    
    func setupItemImage(with viewModel: ItemTableViewCellViewModel) {
        if let url = viewModel.imageURL {
            itemImageView.loadImage(at: url)
        }
        itemImageView.backgroundColor = .lightGray
        addSubview(itemImageView)
        
        itemImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            itemImageView.widthAnchor.constraint(equalToConstant: 72),
            itemImageView.heightAnchor.constraint(equalToConstant: 72),
            itemImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            itemImageView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            itemImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
        ])
        
        itemImageView.layer.masksToBounds = true
        itemImageView.layer.cornerRadius = 2
    }
    
    func setupTitleLabel(with viewModel: ItemTableViewCellViewModel) {
        titleLabel.text = viewModel.title
        titleLabel.font = .systemFont(ofSize: 16)
        titleLabel.textColor = .black
        addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            titleLabel.heightAnchor.constraint(equalToConstant: 24),
            titleLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }
    
    func setupCategoryLabel(with viewModel: ItemTableViewCellViewModel) {
        categoryTag.label.text = viewModel.category.name
        categoryTag.label.font = .boldSystemFont(ofSize: 12)
        categoryTag.label.textColor = .white
        categoryTag.gradientColors = viewModel.category.gradientColors
        
        addSubview(categoryTag)
        
        categoryTag.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            categoryTag.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            categoryTag.heightAnchor.constraint(equalToConstant: 16),
            categoryTag.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 16)
        ])
    }
    
    func setupPriceLabel(with viewModel: ItemTableViewCellViewModel) {
        priceLabel.text = viewModel.price
        priceLabel.textColor = .black
        priceLabel.font = UIFont.monospacedDigitSystemFont(ofSize: 16, weight: .bold)
        addSubview(priceLabel)

        priceLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: categoryTag.bottomAnchor, constant: 8),
            priceLabel.heightAnchor.constraint(equalToConstant: 24),
            priceLabel.leadingAnchor.constraint(equalTo: itemImageView.trailingAnchor, constant: 16)
        ])
    }
}
