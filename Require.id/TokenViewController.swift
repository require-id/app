//  require.id 2019

import UIKit

final class TokenViewController: UIViewController {

    private let token: TokenViewModel

    init(token: TokenViewModel) {
        self.token = token

        super.init(nibName: nil, bundle: nil)

        navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "Close", style: .plain, target: self, action: #selector(didTapClose))
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .blueberry

        view.addSubview(stackView)

        let issuerView = TupleView()
        issuerView.title = "ISSUER"
        issuerView.subtitle = token.issuer

        let userView = TupleView()
        userView.title = "USER"
        userView.subtitle = token.name

        stackView.addArrangedSubview(issuerView)
        stackView.addArrangedSubview(userView)

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor)
            ])
    }

    // MARK: - Action

    @objc
    private func didTapClose() {
        dismiss(animated: true)
    }

    // MARK: - Views

    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .center
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

}

final class TupleView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)

        commonInit()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func commonInit() {
        addSubview(titleLabel)
        addSubview(subtitleLabel)
    }

    // MARK: - Public

    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }

    var subtitle: String? {
        didSet {
            subtitleLabel.text = subtitle
        }
    }

    // MARK: - Subviews

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .sakura
        return label
    }()

    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .sakura
        return label
    }()
}
