// Require.id 2019

import UIKit

struct Setting {
    let title: String
}

struct SettingSection {
    let title: String
    let settings: [Setting]

    var settingsCount: Int {
        return settings.count
    }

    func setting(at index: Int) -> Setting {
        return settings[index]
    }
}

final class SettingsViewController: UITableViewController {

    let sections = [
        SettingSection(title: "BACKUP", settings: [Setting(title: "Create backup"), Setting(title: "Restore backup")]),
        SettingSection(title: "PROFILE", settings: [Setting(title: "Profile")]),
        SettingSection(title: "USER INTERFACE", settings: [Setting(title: "Rainbows"), Setting(title: "Light Mode")])
    ]

    enum Identifier: String {
        case titleCell = "title_cell_identifier"
        case sectionHeader = "section_header"
    }

    required init(appController: AppController) {
        super.init(style: .grouped)

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close",
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(didTapClose))
    }

    override init(style: UITableView.Style) {
        fatalError("init(style:) has not been implemented")
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        view.backgroundColor = UIColor.blueberry

        tableView.register(TitleCell.self, forCellReuseIdentifier: Identifier.titleCell.rawValue)
        tableView.register(SectionTitleView.self, forHeaderFooterViewReuseIdentifier: Identifier.sectionHeader.rawValue)
    }

    // MARK: - Actions

    @objc
    private func didTapClose() {
        dismiss(animated: true)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].settingsCount
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.titleCell.rawValue,
                                                       for: indexPath) as? TitleCell else { fatalError() }

        let setting = sections[indexPath.section].setting(at: indexPath.row)
        cell.titleLabel.text = setting.title

        return cell
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: Identifier.sectionHeader.rawValue) as? SectionTitleView else { fatalError()}

        header.titleLabel.text = sections[section].title

        return header
    }

    // MARK: - View

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
