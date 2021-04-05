//
//  InfluencerCell.swift
//  ExpertChow
//
//  Created by Adam Sterrett on 3/10/21.
//



import Foundation
import UIKit
import Kingfisher

class InfluencerCell: UITableViewCell {
    static let cellIdentifier = "InfluencerCell"

    @IBOutlet private weak var influencerImageView: UIImageView!
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!

    var influencer: Influencer? {
        didSet {
            updateCellView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = ColorStyle.clear.color()
        selectionStyle = .none
        setUpImageView()
        setUpTitleLabel()
        setUpDescriptionLabel()
    }
}

private extension InfluencerCell {
    func setUpTitleLabel() {
        usernameLabel.isAccessibilityElement = true
        usernameLabel.accessibilityIdentifier = "Influencer username"
        usernameLabel.font = FontStyle.primaryMedium.font(size: 20)
        usernameLabel.textColor = ColorStyle.textBlack.color()
        usernameLabel.textAlignment = .left
    }
    
    func setUpDescriptionLabel() {
        descriptionLabel.isAccessibilityElement = true
        descriptionLabel.accessibilityIdentifier = "Description of influencer page"
        descriptionLabel.font = FontStyle.primaryMedium.font(size: 20)
        descriptionLabel.textColor = ColorStyle.textBlack.color()
        descriptionLabel.textAlignment = .left
    }
    
    func setUpImageView() {
        influencerImageView.translatesAutoresizingMaskIntoConstraints = false
        influencerImageView.contentMode = .scaleAspectFill
        influencerImageView.layer.borderWidth = 1.0
    }

    func updateCellView() {
     
        guard let influencerImageView = influencerImageView, let usernameLabel = usernameLabel, let descriptionLabel = descriptionLabel  else { return }
       
        if let username = influencer?.username {
            usernameLabel.text = "@\(String(describing: username))"
        }
        
        descriptionLabel.text = influencer?.description
        
        guard let image = influencer?.url else { return }
        let key = image.cacheKey
        if ImageCache.default.imageCachedType(forKey: key) == .disk {
            influencerImageView.kf.setImage(with: image, options: [.loadDiskFileSynchronously])
        } else {
            influencerImageView.kf.setImage(with: image)
        }
    }
}

