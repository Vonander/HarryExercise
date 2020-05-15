//
//  UIView+Constraints.swift
//  HarryExercise
//
//  Created by Johan Fornander on 2020-05-15.
//  Copyright © 2020 Johan Fornander. All rights reserved.
//

import UIKit

extension UIView {
    func constraint(top: NSLayoutYAxisAnchor? = nil,
                    leading: NSLayoutXAxisAnchor? = nil,
                    bottom: NSLayoutYAxisAnchor? = nil,
                    trailing: NSLayoutXAxisAnchor? = nil,
                    centerX: NSLayoutXAxisAnchor? = nil,
                    centerY: NSLayoutYAxisAnchor? = nil,
                    padding: UIEdgeInsets = .zero,
                    size: CGSize = .zero)  {

        translatesAutoresizingMaskIntoConstraints = false

        if let top = top {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
        }

        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
        }

        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
        }

        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }

        if let centerX = centerX {
            centerXAnchor.constraint(equalTo: centerX).isActive = true
        }

        if let centerY = centerY {
            centerYAnchor.constraint(equalTo: centerY).isActive = true
        }

        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }

        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }

    func fill(parent: UIView) {
        parent.addSubview(self)
        constraint(top: parent.topAnchor, leading: parent.leadingAnchor, bottom: parent.bottomAnchor, trailing: parent.trailingAnchor)
    }
}
