//
//  UIImageView+Load.swift
//  HarryExercise
//
//  Created by Johan Fornander on 2020-05-15.
//  Copyright © 2020 Johan Fornander. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    func load(urlString: String) {

        guard let url = URL(string: urlString) else { return }

        image = nil

        if let imageFromCache = imageCache.object(forKey: url.absoluteString as NSString) as? UIImage {
            self.image = imageFromCache

            return
        }

        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if UIImage(data: data) != nil {
                    DispatchQueue.main.async {
                        let imageToCache = UIImage(data: data)!
                        imageCache.setObject(imageToCache, forKey: url.absoluteString as NSString)
                        
                        self?.image = imageToCache
                    }
                }
            }
        }
    }
}
