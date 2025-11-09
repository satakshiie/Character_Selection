//
//  FriendTableViewCell.swift
//  Exertia
//
//  Created by Ekansh Jindal on 09/11/25.
//

import UIKit

class FriendTableViewCell: UITableViewCell {
 
    @IBOutlet weak var nameLabel: UILabel!
    
    
   
    @IBOutlet weak var infoButton: UIButton!
    
    
    @IBOutlet weak var inviteButton: UIButton!
    
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var statusIndicatorView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        statusIndicatorView.layer.cornerRadius = statusIndicatorView.frame.width / 2
                statusIndicatorView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
