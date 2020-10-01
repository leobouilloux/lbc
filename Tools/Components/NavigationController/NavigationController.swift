//
//  NavigationController.swift
//  LBC
//
//  Created by Leo Marcotte on 25/09/2020.
//  Copyright © 2020 Leo Marcotte. All rights reserved.
//

import UIKit

public class NavigationController: UINavigationController {
    private let backButton = UIBarButtonItem(
        image: Assets.Icons.chevronLeft,
        style: .plain,
        target: nil,
        action: #selector(backButtonPressed(sender:))
    )
    private let closeButton = UIBarButtonItem(
        image: UIImage(named: "xmark"),
        style: .plain,
        target: nil,
        action: nil
    )
    public let loaderController = LoaderController()

    private var showCloseButton: Bool = true

    override public var viewControllers: [UIViewController] {
        didSet {
            if viewControllers.count == 1
                && presentingViewController != nil
                && showCloseButton
                && viewControllers.first?.navigationItem.leftBarButtonItem == nil {
                viewControllers.first?.navigationItem.leftBarButtonItem = closeButton
            }
        }
    }

    public init(rootViewController: UIViewController, showCloseButton: Bool = true) {
        self.showCloseButton = showCloseButton
        super.init(rootViewController: rootViewController)
    }

    public init(showCloseButton: Bool = true) {
        self.showCloseButton = showCloseButton
        super.init(rootViewController: UIViewController())
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override public func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    override public func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if viewControllers.count == 1
            && presentingViewController != nil
            && showCloseButton
            && viewControllers.first?.navigationItem.leftBarButtonItem == nil {
            viewControllers.first?.navigationItem.leftBarButtonItem = closeButton
        }
    }

    override public func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.isEmpty {
        } else {
            viewController.navigationItem.backBarButtonItem = nil
            viewController.navigationItem.leftBarButtonItem = backButton
        }

        super.pushViewController(viewController, animated: animated)
    }

    override public func popViewController(animated: Bool) -> UIViewController? {
        if viewControllers.count <= 1 {
            navigationItem.leftBarButtonItem = closeButton
        } else {
            navigationItem.leftBarButtonItem = backButton
        }
        return super.popViewController(animated: animated)
    }
}

private extension NavigationController {
    /* View */
    func setupView() {
        setupNavigationBar()
    }

    func setupNavigationBar() {
        navigationItem.backBarButtonItem = nil
        navigationItem.leftBarButtonItem = closeButton
    }

    /* Actions */
    @objc func backButtonPressed(sender: UIBarButtonItem) {
        _ = self.popViewController(animated: true)
    }

    @objc func closeButtonPressed(sender: UIBarButtonItem) {

    }

    /* Action */
    func backButtonAction() {
        if self.viewControllers.count > 1 {
            _ = self.popViewController(animated: true)
        }
    }

    func closeButtonAction() {

    }
}

public extension NavigationController {
    // MARK: - Loader
    func showLoader(completion: (() -> Void)? = nil) {
        self.loaderController.modalPresentationStyle = .overFullScreen
        self.loaderController.modalTransitionStyle = .crossDissolve
        self.present(self.loaderController, animated: true, completion: completion)
    }

    func hideLoader(completion: (() -> Void)? = nil) {
        self.loaderController.dismiss(animated: true, completion: completion)
    }
}
