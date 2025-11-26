
import UIKit

class WeightGoalCardView: UIView {
    
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var progressWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var trackView: UIView!
    
    func configure(start: Double, current: Double, target: Double) {
            
            // 1. Calculate total amount to lose (e.g., 78 - 73 = 5)
            let totalToLose = start - target
            
            // 2. Calculate amount lost so far (e.g., 78 - 75 = 3)
            let lostSoFar = start - current
            
            // 3. Calculate percentage (e.g., 3 / 5 = 0.6)
            var progressRatio: CGFloat = 0.0
            
            if totalToLose > 0 {
                progressRatio = CGFloat(lostSoFar / totalToLose)
            }
            
            // 4. Update the bar
            self.setProgress(to: progressRatio)
        }
    
    func setProgress(to value: CGFloat) {
            
            // 1. Safety Check: Just check if the critical views exist
            guard let existingConstraint = progressWidthConstraint,
                  let pView = progressView,
                  let tView = trackView else {
                print("Error: Missing connections. Ensure Pink View, Grey Track, and Constraint are connected.")
                return
            }

            // 2. Limit the value between 0.0 and 1.0
            let clampedValue = min(max(value, 0), 1)

            // 3. Deactivate the old constraint
            existingConstraint.isActive = false

            // 4. Create the NEW constraint directly using the views we know exist
            let newConstraint = pView.widthAnchor.constraint(
                equalTo: tView.widthAnchor,
                multiplier: clampedValue
            )

            // 5. Activate it and save it back
            newConstraint.isActive = true
            self.progressWidthConstraint = newConstraint

            // 6. Animate
            UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseOut) {
                self.layoutIfNeeded()
            }
        }
        

    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Check if we already added the gradient. If not, create and add it.
        if progressView.layer.sublayers?.first is CAGradientLayer == false {
            let gradient = CAGradientLayer()
            
            // 1. The 4 Colors from Figma
            gradient.colors = [
                UIColor(hex: "#FFEFBE").cgColor, // Pale Yellow
                UIColor(hex: "#FFA6DF").cgColor, // Pinkish
                UIColor(hex: "#FF81EF").cgColor, // Darker Pink
                UIColor(hex: "#FF5CFF").cgColor  // Purple/Magenta
            ]
            
            // 2. The Locations (Percentages converted to 0.0 - 1.0)
            // 0%, 47%, 74%, 97%
            gradient.locations = [0.0, 0.47, 0.74, 0.97]
            
            // 3. Direction: Left to Right
            gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
            
            progressView.layer.insertSublayer(gradient, at: 0)
        }
        
        // Update the gradient frame if the view layout changes
        if let gradient = progressView.layer.sublayers?.first as? CAGradientLayer {
            gradient.frame = progressView.bounds
            gradient.cornerRadius = progressView.layer.cornerRadius
        }
    }
    }

