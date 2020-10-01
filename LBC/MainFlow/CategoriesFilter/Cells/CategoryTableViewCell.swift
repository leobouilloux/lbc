//
//  CategoryTableViewCell.swift
//  LBC
//
//  Created by Leo Marcotte on 29/09/2020.
//  Copyright © 2020 Leo Marcotte. All rights reserved.
//

import UIKit

final class CategoryTableViewCell: UITableViewCell {
    private let categoryTag = GradientTag()

    var viewModel: CategoryTableViewCellViewModelInterface?

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        selectionStyle = .none
    }

    func setup(with viewModel: CategoryTableViewCellViewModelInterface) {
        self.viewModel = viewModel

        setupView(with: viewModel)
    }
}

private extension CategoryTableViewCell {
    /* View */
    func setupView(with viewModel: CategoryTableViewCellViewModelInterface) {
        setupCategoryLabel(with: viewModel)
    }

    func setupCategoryLabel(with viewModel: CategoryTableViewCellViewModelInterface) {
        categoryTag.label.text = viewModel.title
        categoryTag.label.font = .boldSystemFont(ofSize: 24)
        categoryTag.label.textColor = .white
        categoryTag.gradientColors = viewModel.gradientColors

        addSubview(categoryTag)

        categoryTag.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            categoryTag.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            categoryTag.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            categoryTag.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            categoryTag.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -16)
        ])
    }
}
