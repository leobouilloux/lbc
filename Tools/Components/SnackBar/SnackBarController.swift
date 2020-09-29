//
//  SnackBarController.swift
//  LBC
//
//  Created by Leo Marcotte on 24/09/2020.
//  Copyright © 2020 Leo Marcotte. All rights reserved.
//

import UIKit

public class SnackBarController {
    var snackBarTopConstraint = NSLayoutConstraint()

    var parentView: UIView?
    let snackBar = SnackBar()
    
    func setup(in controller: UIViewController) {
        parentView = controller.view

        controller.view.addSubview(snackBar)
        snackBar.translatesAutoresizingMaskIntoConstraints = false

        guard let parentView = self.parentView else { return }
        
        if #available(iOS 11, *) {
            snackBarTopConstraint = snackBar.topAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.topAnchor)
        } else {
            snackBarTopConstraint = snackBar.topAnchor.constraint(equalTo: controller.topLayoutGuide.bottomAnchor)
        }
        NSLayoutConstraint.activate([
            snackBarTopConstraint,
            snackBar.leftAnchor.constraint(equalTo: parentView.leftAnchor, constant: 16),
            snackBar.rightAnchor.constraint(equalTo: parentView.rightAnchor, constant: -16)
        ])
        snackBar.layer.cornerRadius = 15
        snackBarTopConstraint.constant = -56
        snackBar.isHidden = true
    }

    public func error(message: String) {
        snackBar.type = .error
        snackBar.messageLabel.text = message
        animate()
    }

    public func warning(message: String) {
        snackBar.type = .warning
        snackBar.messageLabel.text = message
        animate()
    }

    public func success(message: String) {
        snackBar.type = .success
        snackBar.messageLabel.text = message
        animate()
    }

    public func info(message: String) {
        snackBar.type = .info
        snackBar.messageLabel.text = message
        animate()
    }

    private func animate() {
        snackBar.isHidden = false
        self.snackBarTopConstraint.constant = 0

        UIView.animate(withDuration: 1, animations: {
            self.parentView?.layoutIfNeeded()
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 2 + 1) {
            self.snackBarTopConstraint.constant = -self.snackBar.frame.height
            UIView.animate(withDuration: 1, animations: {
                self.parentView?.layoutIfNeeded()
            }) { _ in
                self.snackBar.isHidden = true
            }
        }
    }
}
