//
//  LoadingCell.swift
//  HarryExercise
//
//  Created by Johan Fornander on 2020-05-17.
//  Copyright © 2020 Johan Fornander. All rights reserved.
//

import UIKit

class LoadingCell: UITableViewCell {

    var activityIndicatior: UIActivityIndicatorView = {
        let activityIndicatior = UIActivityIndicatorView(style: .large)

        return activityIndicatior
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addSubview(activityIndicatior)
        activityIndicatior.constraint(centerX: centerXAnchor, centerY: centerYAnchor)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
