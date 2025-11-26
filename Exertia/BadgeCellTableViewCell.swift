import UIKit

class BadgeSwiftTableViewCell: UITableViewCell {

    @IBOutlet weak var cardBackgroundView: UIView!
    @IBOutlet weak var badgeIcon: UIImageView!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView?
    @IBOutlet weak var progressPercentageLabel: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // --- STYLING ---
        // 1. Transparent Cell Background
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        
        // 2. Card Styling
        cardBackgroundView.layer.cornerRadius = 15
        // Optional: Add a subtle shadow to make it pop
        cardBackgroundView.layer.shadowColor = UIColor.black.cgColor
        cardBackgroundView.layer.shadowOpacity = 0.3
        cardBackgroundView.layer.shadowOffset = CGSize(width: 0, height: 4)
        cardBackgroundView.layer.shadowRadius = 4
        
        // 3. Progress Bar Styling
        progressBar?.progressTintColor = UIColor(named: "TitleColor")
        progressBar?.trackTintColor = UIColor.lightGray.withAlphaComponent(0.3)
        progressBar?.layer.cornerRadius = 4
        progressBar?.clipsToBounds = true
        progressBar?.layer.masksToBounds = true
    }
}
