//
//  UIImageViewLoader.swift
//  LBC
//
//  Created by Leo Marcotte on 25/09/2020.
//  Copyright © 2020 Leo Marcotte. All rights reserved.
//

import UIKit

class UIImageLoader {
    static let loader = UIImageLoader()

    private let imageLoader = ImageLoader()
    private var uuidMap = [UIImageView: UUID]()

    private init() {}

    func load(_ url: URL, for imageView: UIImageView, contentMode: UIImageView.ContentMode) {
        let token = imageLoader.loadImage(url) { result in
            defer { self.uuidMap.removeValue(forKey: imageView) }
            let image: UIImage
            let imageViewContentMode: UIImageView.ContentMode
            let imageViewTintColor: UIColor?
            do {
                image = try result.get()
                imageViewContentMode = contentMode
                imageViewTintColor = nil
            } catch {
                image = Assets.Icons.cameraOff
                imageViewContentMode = .center
                imageViewTintColor = .white
            }
            self.animateImageView(
                for: imageView,
                image: image,
                tintColor: imageViewTintColor,
                contentMode: imageViewContentMode
            )
        }
        if let token = token {
            uuidMap[imageView] = token
        }
    }

    private func animateImageView(for imageView: UIImageView, image: UIImage, tintColor: UIColor?, contentMode: UIImageView.ContentMode) {
        DispatchQueue.main.async {
            UIView
                .transition(
                    with: imageView,
                    duration: 0.3,
                    options: .transitionCrossDissolve,
                    animations: {
                        if let color = tintColor {
                            imageView.tintColor = color
                        }
                        imageView.image = image
                        imageView.contentMode = contentMode
                }, completion: nil)
        }
    }

    func cancel(for imageView: UIImageView) {
        if let uuid = uuidMap[imageView] {
            imageLoader.cancelLoad(uuid)
            uuidMap.removeValue(forKey: imageView)
        }
    }
}

extension UIImageView {
    func loadImage(at url: URL, contentMode: UIImageView.ContentMode = .scaleAspectFill) {
        UIImageLoader.loader.load(url, for: self, contentMode: contentMode)
    }

    func cancelImageLoad() {
        UIImageLoader.loader.cancel(for: self)
    }
}
