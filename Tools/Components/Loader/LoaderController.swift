//
//  LoaderController.swift
//  LBC
//
//  Created by Leo Marcotte on 24/09/2020.
//  Copyright © 2020 Leo Marcotte. All rights reserved.
//

import UIKit

public final class LoaderController: UIViewController {
    let activityIndicator = UIActivityIndicatorView()

    override public func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
}

private extension LoaderController {
    /******************************************************/
    // MARK: - View
    func setupView() {
        view.backgroundColor = UIColor.systemGray.withAlphaComponent(0.2)

        setupActivityIndicatorView()
    }

    func setupActivityIndicatorView() {
        activityIndicator.backgroundColor = Style.Loader.backgroundColor
        if #available(iOS 13, *) {
            activityIndicator.style = .medium
        } else {
            activityIndicator.style = .gray
        }
        activityIndicator.color = Style.Loader.tintColor
        
        activityIndicator.layer.cornerRadius = 15
        activityIndicator.layer.masksToBounds = true
        view.addSubview(activityIndicator)

        activityIndicator.startAnimating()

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.widthAnchor.constraint(equalToConstant: 55),
            activityIndicator.heightAnchor.constraint(equalToConstant: 55)
        ])
    }

    /******************************************************/
    // MARK: - RxBindings
    func setupRxBindings() {

    }
}
