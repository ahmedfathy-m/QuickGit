//
//  OptionCell.swift
//  QuickGit
//
//  Created by Ahmed Fathy on 12/08/2022.
//

import UIKit

class OptionCell: UITableViewCell {
    
    //MARK: - View Outlets
    
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var cellIcon: UIImageView!
    @IBOutlet weak var cellSwitch: UISwitch!
    
    //MARK: - Cell Configuration
    var sectionType: OptionType? {
        didSet {
            guard let sectionType = sectionType else { return }
            cellLabel.text = sectionType.description
            cellSwitch.isHidden = !(sectionType.hasSwitch)
            cellIcon.image = sectionType.icon
            cellIcon.isHidden = (sectionType.icon == nil)
            cellIcon.backgroundColor = sectionType.iconColor
        }
    }
    
    //MARK: - Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellIcon.layer.cornerRadius = 4
//        self.accessoryType = .disclosureIndicator
    }
    
    //MARK: - Nib and Identifier
    
    static func nib() -> UINib {
        return UINib(nibName: "OptionCell", bundle: nil)
    }
    
    static let identifier = "OptionCell"
    
}
