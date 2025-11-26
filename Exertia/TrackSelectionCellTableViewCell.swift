import UIKit

class TrackSelectionCellTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var trackImageView: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Don't change selection color
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Add spacing between cells by reducing the content frame (reduced spacing)
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 3, left: 0, bottom: 3, right: 0))
    }
    
    // MARK: - Setup
    private func setupUI() {
            selectionStyle = .none
            backgroundColor = .clear
            contentView.backgroundColor = .clear
            
            containerView?.layer.cornerRadius = 20
            containerView?.clipsToBounds = true
            
            trackImageView?.layer.cornerRadius = 15
            trackImageView?.clipsToBounds = true
            
            // Fonts
            if let audiowideFont = UIFont(name: "Audiowide-Regular", size: 18) {
                trackNameLabel?.font = audiowideFont
            }
            
            // Description Font (Regular system font for readability)
            descriptionLabel?.font = UIFont.systemFont(ofSize: 13, weight: .regular)
            descriptionLabel?.numberOfLines = 3 // Allow wrapping
            descriptionLabel?.alpha = 0.9 // Slightly dimmer than title
        }
    
    // MARK: - Configuration
    func configure(trackName: String, description: String, trackImage: String, isSelected: Bool) {
            trackNameLabel.text = trackName
            descriptionLabel.text = description
            trackImageView.image = UIImage(named: trackImage)
            
            if isSelected {
                containerView.backgroundColor = UIColor(red: 0.851, green: 0.769, blue: 0.620, alpha: 0.3)
                let titleColor = UIColor(red: 0.957, green: 0.878, blue: 0.702, alpha: 1.0)
                trackNameLabel.textColor = titleColor
                descriptionLabel.textColor = titleColor
            } else {
                containerView.backgroundColor = UIColor(red: 0.310, green: 0.243, blue: 0.431, alpha: 1.0)
                trackNameLabel.textColor = .white
                descriptionLabel.textColor = .white
            }
    }
}
