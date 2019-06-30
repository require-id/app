// Require.io 2019

import UIKit

final class TokenCell: UITableViewCell {

    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        commonInit()
    }

    private func commonInit() {
        backgroundColor = UIColor.blueberry

        let selectionView = UIView()
        selectionView.backgroundColor = UIColor.currant
        selectedBackgroundView = selectionView

        contentView.addSubview(container)

        NSLayoutConstraint.activate([
            container.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            container.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
            container.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor)
            ])

        container.addArrangedSubview(textContainer)
        container.addArrangedSubview(UIView()) // Add spacing
        container.addArrangedSubview(tokenLabel)

        textContainer.addArrangedSubview(issuerLabel)
        textContainer.addArrangedSubview(nameLabel)
    }

    // MARK: - Subviews

    private var container: UIStackView = {
        let stackview = UIStackView()
        stackview.translatesAutoresizingMaskIntoConstraints = false
        stackview.distribution = .fill
        stackview.axis = .horizontal
        return stackview
    }()

    private var textContainer: UIStackView = {
        let stackview = UIStackView()
        stackview.distribution = .fill
        stackview.axis = .vertical
        return stackview
    }()

    var issuerLabel: UILabel = {
        let label = UILabel()
        label.font = .cellTitle
        label.adjustsFontForContentSizeCategory = true
        label.textColor = UIColor.gingerbread
        return label
    }()

    var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .cellSubtitle
        label.adjustsFontForContentSizeCategory = true
        label.textColor = UIColor.gingerbread.withAlphaComponent(0.8)
        return label
    }()

    var tokenLabel: UILabel = {
        let label = UILabel()
        label.font = .cellLarge
        label.adjustsFontForContentSizeCategory = true
        label.textColor = UIColor.gingerbread
        return label
    }()
}
