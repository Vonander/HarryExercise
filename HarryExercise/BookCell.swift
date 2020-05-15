//
//  BookCell.swift
//  HarryExercise
//
//  Created by Johan Fornander on 2020-05-12.
//  Copyright © 2020 Johan Fornander. All rights reserved.
//

import UIKit

class BookCell: UITableViewCell {

    var coverImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 10
        image.clipsToBounds = true

        return image
    }()

    var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .black

        return label
    }()

    var authorLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .black

        return label
    }()

    var narratorLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = .black

        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addSubViews()
        setConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func addSubViews() {
        addSubview(coverImage)
        addSubview(titleLabel)
        addSubview(authorLabel)
        addSubview(narratorLabel)
    }

    private func setConstraints() {
        coverImage.constraint(leading: leadingAnchor,
                              centerY: centerYAnchor,
                              padding: .init(top: 0, left: 12, bottom: 0, right: 0),
                              size: .init(width: 80, height: 80))

        titleLabel.constraint(top: topAnchor,
                              leading: coverImage.trailingAnchor,
                              trailing: trailingAnchor,
                              padding: .init(top: 8, left: 20, bottom: 0, right: 10))

        authorLabel.constraint(top: titleLabel.bottomAnchor,
                               leading: coverImage.trailingAnchor,
                               trailing: trailingAnchor,
                               padding: .init(top: 8, left: 20, bottom: 0, right: 10))

        narratorLabel.constraint(top: authorLabel.bottomAnchor,
                               leading: coverImage.trailingAnchor,
                               trailing: trailingAnchor,
                               padding: .init(top: 8, left: 20, bottom: 0, right: 10))
    }
}
