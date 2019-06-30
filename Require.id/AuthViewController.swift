//
//  AuthViewController.swift
//  Require.id
//
//  Created by Emil Bogren on 2019-06-29.
//  Copyright © 2019 Emil Bogren. All rights reserved.
//

import UIKit
import LocalAuthentication

final class AuthViewController: UIViewController {

    var context = LAContext()

    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    private let appController: AppController

    init(appController: AppController) {
        self.appController = appController
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.blueberry
        view.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])

        let reason = "Log in to your account"
        context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason ) { success, error in

            if success {
                // Move to the main thread because a state update triggers UI changes.
                DispatchQueue.main.async { [weak self] in
                    self?.appController.didAuthenticate()
                }
            } else {
                print(error?.localizedDescription ?? "Failed to authenticate")

                // Fall back to a asking for username and password.
                // ...
            }
        }
    }

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false

        let title = "require.id"
        var attributtedText = NSMutableAttributedString(string: title,
                                                        attributes: [.font: UIFont.title1,
                                                                     .foregroundColor: UIColor.gingerbread])
        if let range = title.range(of: ".id") {
            attributtedText.addAttributes([.foregroundColor: UIColor.fizz], range: NSRange(range, in: title))
        }

        label.attributedText = attributtedText
        return label
    }()
}
