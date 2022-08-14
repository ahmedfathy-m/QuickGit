//
//  SettingsViewController.swift
//  QuickGit
//
//  Created by Ahmed Fathy on 13/08/2022.
//

import UIKit

class SettingsViewController: UIViewController {
    weak var coordinator: MainCoordinator?
    //MARK: - UI Elements
    let tableView = UITableView(frame: .null, style: .insetGrouped)
    let handler = SettingsTableHandler()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = handler
        tableView.register(OptionCell.nib(), forCellReuseIdentifier: OptionCell.identifier)
        tableView.delegate = handler
    }
    
    override func viewWillAppear(_ animated: Bool) {
        view.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}
