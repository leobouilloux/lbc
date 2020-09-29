//
//  SplashScreenViewController.swift
//  LBC
//
//  Created by Leo Marcotte on 26/09/2020.
//  Copyright © 2020 Leo Marcotte. All rights reserved.
//

import UIKit

final class SplashScreenViewController: BaseViewController {
    let viewModel: SplashScreenViewModel

    private let logoImageView: UIImageView
    private let avatarView: UIView
    private let avatarImageView: UIImageView
    private let avatarLabel: UILabel
    private let activityIndicatorView: UIActivityIndicatorView
    
    init(with viewModel: SplashScreenViewModel) {
        self.viewModel = viewModel
        self.logoImageView = UIImageView()
        self.avatarView = UIView()
        self.avatarImageView = UIImageView()
        self.avatarLabel = UILabel()
        self.activityIndicatorView = UIActivityIndicatorView(style: .whiteLarge)
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.viewModel.output?.didFinishLoading()
        }
    }
}

private extension SplashScreenViewController {
    /******************************************/
    /* View */
    func setupView() {
        view.backgroundColor = UIColor(hex: "#F56B29")

        setupLogoImageView()
        setupActivityIndicatorView()
        setupAvatarView()
    }
    
    func setupLogoImageView() {
        logoImageView.image = UIImage(named: "leboncoin-logo")
        logoImageView.tintColor = .white
        logoImageView.contentMode = .scaleAspectFit
        view.addSubview(logoImageView)
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            NSLayoutConstraint(
                item: logoImageView, attribute: .centerY,
                relatedBy: .equal,
                toItem: view, attribute: .centerY,
                multiplier: 0.5, constant: 0
            ),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            logoImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    func setupActivityIndicatorView() {
        activityIndicatorView.startAnimating()
        view.addSubview(activityIndicatorView)
        
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func setupAvatarView() {
        view.addSubview(avatarView)
        
        setupAvatarImageView()
        setupAvatarLabel()
        
        avatarView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            NSLayoutConstraint( // this is not possible using anchors for some reason
                item: avatarView, attribute: .centerY,
                relatedBy: .equal,
                toItem: view, attribute: .centerY,
                multiplier: 1.5, constant: 0
            ),
            avatarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            avatarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            avatarView.heightAnchor.constraint(equalToConstant: 64)
        ])

    }
    
    func setupAvatarImageView() {
        avatarImageView.image = UIImage(named: "avatar")
        avatarImageView.contentMode = .scaleAspectFit
        avatarView.addSubview(avatarImageView)
        
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: avatarView.topAnchor),
            avatarImageView.bottomAnchor.constraint(equalTo: avatarView.bottomAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: avatarView.leadingAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 64),
            avatarImageView.heightAnchor.constraint(equalToConstant: 64)
        ])
        
        avatarImageView.layer.masksToBounds = true
        avatarImageView.layer.cornerRadius = 32
    }
    
    func setupAvatarLabel() {
        avatarLabel.font = .boldSystemFont(ofSize: 14)
        avatarLabel.textColor = .white
        avatarLabel.numberOfLines = 0
        avatarLabel.text = Loc.SplashScreen.avatarCaption
        avatarView.addSubview(avatarLabel)
        
        avatarLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            avatarLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor),
            avatarLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            avatarLabel.trailingAnchor.constraint(equalTo: avatarView.trailingAnchor)
        ])
        
    }
}
