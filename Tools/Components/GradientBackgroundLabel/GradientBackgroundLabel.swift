//
//  GradientBackgroundLabel.swift
//  LBC
//
//  Created by Leo Marcotte on 25/09/2020.
//  Copyright © 2020 Leo Marcotte. All rights reserved.
//

import UIKit

class GradientTag: UIView {
    let label = UILabel()
    var gradientColors: (UIColor, UIColor) = (.white, .white)
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        sharedInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        sharedInit()
    }
    
    func sharedInit() {
        setupLabel()
    }
    
    override func draw(_ rect: CGRect) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [gradientColors.0.cgColor, gradientColors.1.cgColor]
        gradientLayer.locations =  [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.frame.size = CGSize(width: 500, height: rect.height)
        layer.insertSublayer(gradientLayer, at: 0)

        
        layer.masksToBounds = true
        layer.cornerRadius = rect.height / 2
        
        super.draw(rect)
    }
}

private extension GradientTag {
    /******************************************/
    /* View */
    func setupLabel() {
        label.textColor = .white
        addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
}
