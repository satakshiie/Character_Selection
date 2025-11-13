import UIKit

class AnimatedGradientView: UIView {
    
    private let gradientLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradient()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGradient()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
    
    private func setupGradient() {
        // More color stops = smoother transition
        let color1 = UIColor(red: 0.85, green: 0.65, blue: 0.65, alpha: 1.0).cgColor  // Pink top
        let color2 = UIColor(red: 0.75, green: 0.5, blue: 0.7, alpha: 1.0).cgColor    // Rose
        let color3 = UIColor(red: 0.6, green: 0.35, blue: 0.65, alpha: 1.0).cgColor   // Purple
        let color4 = UIColor(red: 0.4, green: 0.2, blue: 0.45, alpha: 1.0).cgColor    // Dark purple
        let color5 = UIColor(red: 0.2, green: 0.1, blue: 0.2, alpha: 1.0).cgColor     // Very dark
        let color6 = UIColor.black.cgColor                                             // Black
        
        gradientLayer.colors = [color1, color2, color3, color4, color5, color6]
        gradientLayer.locations = [0.0, 0.2, 0.4, 0.6, 0.8, 1.0]  // Even distribution
        
        // Vertical gradient (top to bottom) for cleaner fade
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        
        layer.insertSublayer(gradientLayer, at: 0)
        animateGradient()
    }

    private func animateGradient() {
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [0.0, 0.2, 0.4, 0.6, 0.8, 1.0]
        animation.toValue = [0.0, 0.15, 0.35, 0.55, 0.75, 1.0]
        animation.duration = 3.0
        animation.autoreverses = true
        animation.repeatCount = .infinity
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        gradientLayer.add(animation, forKey: "locationsAnimation")
    }
        
}
