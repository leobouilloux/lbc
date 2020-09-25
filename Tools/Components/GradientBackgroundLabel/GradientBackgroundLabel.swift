//
//  GradientBackgroundLabel.swift
//  LBC
//
//  Created by Leo Marcotte on 25/09/2020.
//  Copyright © 2020 Leo Marcotte. All rights reserved.
//

import UIKit

class GradientTag: UIView {
    lazy var label: UILabel = setupLabel()
        
    var gradientColors: (UIColor, UIColor) = (.white, .white)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
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
    func setupLabel() -> UILabel {
        let label = UILabel()
        label.textColor = .white
        addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
        return label
    }
}
