//
//  TopUserCell.swift
//  QuickGit
//
//  Created by Ahmed Fathy on 17/08/2022.
//

import UIKit
import Kingfisher

class ExploreCollectionCell: UICollectionViewCell {
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var cardTitleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var repoCountLabel: UILabel!
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var repoMetrics: UIStackView!
    @IBOutlet weak var starCount: UILabel!
    @IBOutlet weak var devLangLabel: UILabel!
    let gradient = CAGradientLayer()
    
    var profileModel: ProfileModel? {
        didSet {
            cardTitleLabel.text = profileModel?.fullName
            subTitleLabel.text = profileModel?.userName
            bioLabel.text = profileModel?.bio
            repoCountLabel.text =  String(profileModel!.numberOfRepos)
            if let imageURL = URL(string: profileModel?.avatarURL ?? "") {
                userImage.kf.setImage(with: imageURL)
            }
            subTitleLabel.isHidden = false
            repoMetrics.isHidden = true
            
            counterLabel.text = "Repositories"
        }
    }
    
    var repoModel: Repository? {
        didSet {
            subTitleLabel.isHidden = true
            repoMetrics.isHidden = false
            counterLabel.text = "Followers"
            cardTitleLabel.text = repoModel?.repoName
            starCount.text = String(repoModel!.starsCount)
            devLangLabel.text = repoModel?.devLang
            bioLabel.text = repoModel?.repoDescription
            repoCountLabel.text = String(repoModel!.followers)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        gradient.colors = [UIColor.systemGray.withAlphaComponent(0.0).cgColor,
                           UIColor.systemGray.cgColor,
                           UIColor.systemGray.cgColor
        ]
        gradient.type = .axial
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        
    }
    
    override func layoutSubviews() {
        self.layer.cornerRadius = 10
        gradient.locations = [0,0.5,1]
        gradientView.layer.addSublayer(gradient)
        gradient.frame = gradientView.frame

    }
    
    static func nib() -> UINib {
        return UINib(nibName: "ExploreCollectionCell", bundle: nil)
    }
    
    static let identifier = "ExploreCollectionCell"

}
