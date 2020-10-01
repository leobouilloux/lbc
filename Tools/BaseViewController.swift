//
//  BaseViewController.swift
//  LBC
//
//  Created by Leo Marcotte on 24/09/2020.
//  Copyright © 2020 Leo Marcotte. All rights reserved.
//

import Foundation
import UIKit

open class BaseViewController: UIViewController {
    public let snackBarController = SnackBarController()
    public let loaderController = LoaderController()

    private var isLoading: Bool = false {
        didSet {
            if self.isLoading {
                showLoader()
            } else {
                hideLoader()
            }
        }
    }

    @available(*, unavailable)
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }

    override open func viewDidLoad() {
        super.viewDidLoad()

        snackBarController.setup(in: self)
    }

    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        view.endEditing(true)
    }
}

public extension BaseViewController {
    // MARK: - Loader
    func showLoader(completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            self.loaderController.modalPresentationStyle = .overFullScreen
            self.loaderController.modalTransitionStyle = .crossDissolve
            self.present(self.loaderController, animated: true, completion: completion)
        }
    }

    func hideLoader(completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            self.loaderController.dismiss(animated: true, completion: completion)
        }
    }
}
