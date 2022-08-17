//
//  ExploreTableHandler.swift
//  QuickGit
//
//  Created by Ahmed Fathy on 17/08/2022.
//

import UIKit

class ExploreTableHandler: NSObject, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ExploreTableCell
        cell.cellType = ExploreSection(rawValue: indexPath.section)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = ExploreSection(rawValue: section)
        return section?.description
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ExploreSection.allCases.count
    }
}

extension ExploreTableHandler: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height / 4
    }
}
