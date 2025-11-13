import UIKit

class TrackSelectionCellTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var trackImageView: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var durationValueLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!
    @IBOutlet weak var caloriesValueLabel: UILabel!
    
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
        
        // Round corners
        containerView?.layer.cornerRadius = 20
        containerView?.clipsToBounds = true
        
        trackImageView?.layer.cornerRadius = 15
        trackImageView?.clipsToBounds = true
        
        // Set Audiowide font programmatically, fallback to system font
        if let audiowideFont = UIFont(name: "Audiowide-Regular", size: 18) {
            trackNameLabel?.font = audiowideFont
        } else {
            // Fallback to rounded system font
            trackNameLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
            print("⚠️ Using system font for track name - Audiowide not found")
        }
        
        if let audiowideFontSmall = UIFont(name: "Audiowide-Regular", size: 13) {
            durationLabel?.font = audiowideFontSmall
            durationValueLabel?.font = audiowideFontSmall
            caloriesLabel?.font = UIFont(name: "Audiowide-Regular", size: 12)
            caloriesValueLabel?.font = audiowideFontSmall
        } else {
            // Fallback to system font
            let systemFont = UIFont.systemFont(ofSize: 13, weight: .medium)
            durationLabel?.font = systemFont
            durationValueLabel?.font = systemFont
            caloriesLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
            caloriesValueLabel?.font = systemFont
        }
    }
    
    // MARK: - Configuration
    func configure(trackName: String, trackImage: String, isSelected: Bool) {
        trackNameLabel.text = trackName
        trackImageView.image = UIImage(named: trackImage)
        
        // Set static values for all cells
        durationValueLabel.text = "00:00:00"
        caloriesValueLabel.text = "25Cal"
        
        // Update colors based on selection
        if isSelected {
            // Selected state - beige with transparency
            containerView.backgroundColor = UIColor(red: 0.851, green: 0.769, blue: 0.620, alpha: 0.3)
            let titleColor = UIColor(red: 0.957, green: 0.878, blue: 0.702, alpha: 1.0)
            trackNameLabel.textColor = titleColor
            durationLabel.textColor = titleColor
            durationValueLabel.textColor = titleColor
            caloriesLabel.textColor = titleColor
            caloriesValueLabel.textColor = titleColor
        } else {
            // Unselected state - solid purple with white text
            containerView.backgroundColor = UIColor(red: 0.310, green: 0.243, blue: 0.431, alpha: 1.0)
            trackNameLabel.textColor = .white
            durationLabel.textColor = .white
            durationValueLabel.textColor = .white
            caloriesLabel.textColor = .white
            caloriesValueLabel.textColor = .white
        }
    }
}
