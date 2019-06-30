//
//  SettingCell.swift
//  require.id
//
//  Created by Emil Bogren on 2019-06-29.
//  Copyright © 2019 Emil Bogren. All rights reserved.
//

import UIKit

final class TitleCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func commonInit() {
        contentView.addSubview(titleLabel)
        contentView.backgroundColor = .blueberry

        let selectionView = UIView()
        selectionView.backgroundColor = .currant
        selectedBackgroundView = selectionView

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: accessoryView?.leadingAnchor ?? contentView.layoutMarginsGuide.trailingAnchor),
        ])
    }

    // MARK: - Subviews

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .cellTitle
        label.textColor = .gingerbread
        return label
    }()
}
