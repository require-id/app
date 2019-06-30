    // Require.io 2019

import UIKit
import Whisper

final class TokensViewController: UIViewController {

    enum Identifier: String {
        case tokenCell = "TokenCellIdentifier"
    }

    private let data = [
        Token(identifier: 0, issuer: "GitHub", name: "bogren"),
        Token(identifier: 1, issuer: "Twitter", name: "emil_bogren"),
        Token(identifier: 2, issuer: "Slack", name: "info@emilbogren.se"),
        Token(identifier: 3, issuer: "Binero", name: "require.io"),
        Token(identifier: 4, issuer: "", name: "npm:k0nserv")
    ]

    // Timer 
    private var timer: Timer?
    private var time: Float = 0

    private var tokens: [TokenViewModel]?

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "require.id"

        tokens = data.map { TokenViewModel(token: $0) }

        runTimer()

        // Setup TableView
        tableView.register(TokenCell.self, forCellReuseIdentifier: Identifier.tokenCell.rawValue)
        tableView.reloadData()
    }

    // MARK: - Actions

    @objc
    private func addToken() {
        let viewController = QRCodeScannerViewController()
        // navigationController?.pushViewController(viewController, animated: true)
        present(viewController, animated: true)
    }

    @objc
    private func openSettings() {
    }

    @IBAction func cancel(_ unwindSegue: UIStoryboardSegue) {
        
    }


    // MARK: - Timer

    private func runTimer() {
        time = 0
        timerView.setProgress(0, animated: false)
        timer = Timer.scheduledTimer(timeInterval: 1 / 60,
                                     target: self,
                                     selector: #selector(updateTimer),
                                     userInfo: nil,
                                     repeats: true)
    }

    @objc
    private func updateTimer() {
        time += 1 / 60
        DispatchQueue.main.async { [weak self] in
            guard let `self` = self else { return }
            self.timerView.setProgress(self.time / 30, animated: false)
        }

        // Restart when we reach 30
        if time >= 30 {
            timer?.invalidate()
            runTimer()
        }
    }

    // MARK: - Views

    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var timerView: UIProgressView!
}

// MARK: - UITableViewDataSource

extension TokensViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tokens?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.tokenCell.rawValue,
                                                       for: indexPath) as? TokenCell else { fatalError() }

        if let token = tokens?[indexPath.row] {
            cell.issuerLabel.text = token.issuer
            cell.nameLabel.text = token.name
            cell.tokenLabel.text = token.code
        }

        return cell
    }
}

// MARK: - UITableViewDelegate

extension TokensViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let murmur = Murmur(title: "Copied token to Clipboard!",
                            backgroundColor: .zest,
                            titleColor: .white,
                            font: .subheadline)

        Whisper.show(whistle: murmur)

        if let token = tokens?[indexPath.row] {
            UIPasteboard.general.string = token.code.filter {
                !($0.isWhitespace || $0.isNewline)
            }
        }
    }

}
