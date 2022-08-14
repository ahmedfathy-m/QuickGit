//
//  UserHeaderView.swift
//  QuickGit
//
//  Created by Ahmed Fathy on 13/08/2022.
//

import UIKit

class UserHeaderView: UITableViewHeaderFooterView {
    
    //MARK: - View Outlets
    @IBOutlet weak var bookmarkButton: UIButton!
    @IBOutlet weak var displayName: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var userBio: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var metrics: UILabel!
    var buttonAction: (() -> ())?
    
    //MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        avatar.layer.cornerRadius = 40
        bookmarkButton.setImage(UIImage(systemName: "bookmark.fill"), for: .selected)
        bookmarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
    }
    
    @IBAction func bookmarkPressed(_ sender: UIButton) {
        sender.isSelected = !(sender.isSelected)
        buttonAction?()
    }
    
    //MARK: - Nib Declaration and Identifier
    
    static func nib() -> UINib {
        return UINib(nibName: "UserHeaderView", bundle: nil)
    }
    
    static let identifier = "UserHeaderView"

}
