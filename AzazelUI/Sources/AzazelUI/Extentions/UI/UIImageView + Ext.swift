//
//  UIImageView + Ext.swift
//  Cannonball
//
//  Created by Bogdan Shmatov on 02.10.2024.
//

import UIKit
import Kingfisher

public extension UIImageView {
    func imageFromServerURL(_ URLString: String,
                            placeHolder: UIImage? = nil,
                            size: CGSize? = nil,
                            neededCache: Bool? = false,
                            onLoaded: ((UIImage) -> Void)? = nil) {
        
        let url = URL(string: URLString)
        var options: KingfisherOptionsInfo = [.scaleFactor(UIScreen.main.scale),
                                              .transition(.fade(0.2))]
        
        if let size = size {
            let processor = DownsamplingImageProcessor(size: size)
            options.append(.processor(processor))
        }
        
        if neededCache ?? false {
            options.append(.cacheOriginalImage)
        }
        
        self.kf.setImage(with: url,
                         placeholder: placeHolder,
                         options: options) { result in
            
            switch result {
            case .success(let value):
                onLoaded?(value.image)
            case .failure(let error):
                print("\(error.localizedDescription)")
            }
        }
    }
}
