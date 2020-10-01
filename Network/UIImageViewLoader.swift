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
            do {
                let image = try result.get()
                DispatchQueue.main.async {
                    UIView
                        .transition(
                            with: imageView,
                            duration: 0.3,
                            options: .transitionCrossDissolve,
                            animations: {
                                imageView.image = image
                                imageView.contentMode = contentMode
                        }, completion: nil)
                }
            } catch {
                DispatchQueue.main.async {
                    UIView
                        .transition(
                            with: imageView,
                            duration: 0.3,
                            options: .transitionCrossDissolve,
                            animations: {
                                imageView.image = Assets.Icons.cameraOff
                                imageView.tintColor = .white
                                imageView.contentMode = .center
                        }, completion: nil)
                }
            }
        }
        if let token = token {
            uuidMap[imageView] = token
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
