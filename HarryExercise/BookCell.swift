//
//  BookCell.swift
//  HarryExercise
//
//  Created by Johan Fornander on 2020-05-12.
//  Copyright © 2020 Johan Fornander. All rights reserved.
//

import UIKit

class BookCell: UITableViewCell {

    var coverImage = UIImageView()
    var titleLabel = UILabel()
    var authorLabel = UILabel()
    var narratorLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addSubview(coverImage)
        addSubview(titleLabel)

        configureImageView()
        configureTitleLabel()

        setImageConstraints()
        setTitleLabelConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureImageView() {
        coverImage.layer.cornerRadius = 10
        coverImage.clipsToBounds = true
    }

    private func configureTitleLabel() {
        titleLabel.numberOfLines = 0
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.text = "hej"
        titleLabel.textColor = .blue
    }

    private func setImageConstraints() {
        coverImage.translatesAutoresizingMaskIntoConstraints = false
        coverImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        coverImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        coverImage.heightAnchor.constraint(equalToConstant: 80).isActive = true
        coverImage.widthAnchor.constraint(equalTo: coverImage.heightAnchor, multiplier: 16/9).isActive = true
    }

    private func setTitleLabelConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: coverImage.trailingAnchor, constant: 20).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
    }
}
