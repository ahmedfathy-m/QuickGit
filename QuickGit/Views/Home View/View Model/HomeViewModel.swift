//
//  HomeViewModel.swift
//  QuickGit
//
//  Created by Ahmed Fathy on 11/08/2022.
//

import UIKit

final class HomeViewModel {
    
    //MARK: - Delegate
    weak var delegate: HomeViewController?
    
    //MARK: - Table Data (Sections, Cells, Icons)
    
    let tableData: [(sectionTitle: String, cells: [String])] = [("Features", ["Users", "Repositories", "Issues", "Github Web"]),
                                                                ("Repos", ["Bookmarked Repos"]),
                                                                ("Mode", ["Guest Mode"])]

    func configure(cell: UITableViewCell,for indexPath:IndexPath) {
        let cell = cell as! OptionCell
        cell.cellSwitch.isHidden = true
        cell.cellLabel.text = tableData[indexPath.section].cells[indexPath.row]
        cell.backgroundColor = .lightGray.withAlphaComponent(0.2)
        cell.selectedBackgroundView?.backgroundColor = .lightGray
    }
}
