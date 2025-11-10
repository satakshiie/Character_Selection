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
        
        let inviteTitle = "Invite"
        let inviteAttributes: [NSAttributedString.Key: Any] = [
                    .font: UIFont(name: "Audiowide-Regular", size: 16)!,
                    .foregroundColor: UIColor(hex: "#EE80F8"), // Pink text color
                    .strokeColor: UIColor.black, // Black stroke for text
                    .strokeWidth: -2.0
                ]
        let attributedInviteTitle = NSAttributedString(string: inviteTitle, attributes: inviteAttributes)
        inviteButton.setAttributedTitle(attributedInviteTitle, for: .normal)
        
        inviteButton.backgroundColor = UIColor(hex: "#F8ECC0") // Your light yellow/cream color
        inviteButton.layer.cornerRadius = 24 // Match your desired roundedness
        inviteButton.layer.borderWidth = 2 // Pink stroke for button
        inviteButton.layer.borderColor = UIColor(hex: "#EE80F8").cgColor // Pink stroke color
        inviteButton.layer.masksToBounds = true
        
        let infoTitle = "Info"
        let infoAttributes: [NSAttributedString.Key: Any] = [
                    .font: UIFont(name: "Audiowide-Regular", size: 16)!,
                    .foregroundColor: UIColor(hex: "#7ED9DA"), // Your teal/blue text color
                    .strokeColor: UIColor.black,
                    .strokeWidth: -2.0
                ]
        
        let attributedInfoTitle = NSAttributedString(string: infoTitle, attributes: infoAttributes)
        infoButton.setAttributedTitle(attributedInfoTitle, for: .normal)
        
        infoButton.backgroundColor = UIColor(hex: "#F8ECC0") // Your light yellow/cream color
        infoButton.layer.cornerRadius = 24
        infoButton.layer.borderWidth = 2
        infoButton.layer.borderColor = UIColor(hex: "#7ED9DA").cgColor // Teal/blue stroke color
        infoButton.layer.masksToBounds = true
        
        avatarImageView.layer.cornerRadius = avatarImageView.frame.width / 2
        avatarImageView.layer.masksToBounds = true
        
        statusIndicatorView.layer.cornerRadius = statusIndicatorView.frame.width / 2
        statusIndicatorView.layer.masksToBounds = true
        
        contentView.backgroundColor = UIColor(hex: "#2F2165")
        contentView.layer.cornerRadius = 24 // Adjust this to match your design
        contentView.layer.masksToBounds = true
        
        self.backgroundColor = .clear
    }
    
    override var frame: CGRect {
            get {
                return super.frame
            }
            set (newFrame) {
                // This line adds 16 points of margin on the left and right
                let insetFrame = newFrame.inset(by: UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16))
                super.frame = insetFrame
            }
        }
    
    override func layoutSubviews() {
            super.layoutSubviews()
            contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}