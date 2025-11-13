import UIKit


class CustomToggleControl: UIView {

    // MARK: - IBOutlets
    @IBOutlet weak var sliderView: UIView!
    @IBOutlet weak var calBurnButton: UIButton!
    @IBOutlet weak var runtimeButton: UIButton!
    @IBOutlet weak var sliderLeadingConstraint: NSLayoutConstraint!
    
    // This flag ensures setup logic only runs ONCE
    private var didSetup = false

    // MARK: - Initialization & Setup
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // DO NOT call setupUI() here. Outlets are often nil.
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // --- Run Setup Once ---
        // We use layoutSubviews to guarantee all outlets are connected
        if !didSetup {
            setupUI()
            didSetup = true
        }
        
        // --- Handle Layout Changes ---
        // This part runs every time layout changes (like rotation)
        // to keep the pill shape perfect.
        self.layer.cornerRadius = self.bounds.height / 2
        sliderView.layer.cornerRadius = sliderView.bounds.height / 2
    }

    private func setupUI() {
    

        self.clipsToBounds = true
        
        // Set initial selected state
        calBurnButton.isSelected = true
        runtimeButton.isSelected = false
        
        let padding: CGFloat = 4.0
        sliderLeadingConstraint.constant = padding
        
        // Set initial text colors
        updateButtonColors(selectedButton: calBurnButton)
     

    }
    
    // MARK: - Actions
    @IBAction func toggleTapped(_ sender: UIButton) {
        guard !sender.isSelected else { return } // Don't do anything if tapping the selected button
        
        calBurnButton.isSelected = (sender == calBurnButton)
        runtimeButton.isSelected = (sender == runtimeButton)
        
        let padding: CGFloat = 4.0
        // We need to know the width of the *slider pill itself*
        let sliderWidth = (self.bounds.width / 2) - (padding * 2) // e.g., (200/2) - (4*2) = 92
        
        if sender == runtimeButton {
            // Move to the right. The new constant is (padding + sliderWidth + padding)
            // A simpler way: just move it halfway across the view's width
            sliderLeadingConstraint.constant = self.bounds.width / 2
        } else {
            // Move to the left.
            sliderLeadingConstraint.constant = padding
        }
        
        // Animate the constraint change
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseOut]) {
            self.layoutIfNeeded() // This tells the view to animate the constraint change
            self.updateButtonColors(selectedButton: sender)
        }
    }

    // MARK: - Helper Methods
    private func updateButtonColors(selectedButton: UIButton) {
        let selectedTextColor = UIColor(red: 0.9, green: 0.9, blue: 0.7, alpha: 1.0) // Light text
        let unselectedTextColor = UIColor.white.withAlphaComponent(0.6) // Faint white
        
        calBurnButton.setTitleColor(calBurnButton.isSelected ? selectedTextColor : unselectedTextColor, for: .normal)
        runtimeButton.setTitleColor(runtimeButton.isSelected ? selectedTextColor : unselectedTextColor, for: .normal)
    }
}
