import UIKit

@IBDesignable
class LiquidGlassView: UIView {

    // Toggle this in Storyboard: On = Thicker "Gummy" Glass, Off = Thin "Water" Glass
    @IBInspectable var isProminent: Bool = false {
        didSet { updateEffect() }
    }
    
    @IBInspectable var cornerRadius: CGFloat = 24.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
            effectView.layer.cornerRadius = cornerRadius
        }
    }

    private var effectView = UIVisualEffectView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        self.backgroundColor = .clear
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        
        // Setup the blur view
        effectView.frame = self.bounds
        effectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(effectView)
        self.sendSubviewToBack(effectView)
        
        updateEffect()
    }

    private func updateEffect() {
        // CORRECTED LOGIC:
        // Use standard Material styles which adapt to light/dark mode automatically.
        // .systemUltraThinMaterial = The "Water" look (transparent, high refraction)
        // .systemThickMaterial = The "Gel" look (more opaque, good for buttons)
        
        let style: UIBlurEffect.Style = isProminent ? .systemThickMaterial : .systemUltraThinMaterial
        effectView.effect = UIBlurEffect(style: style)
        
        // VISUAL TWEAKS for the "Liquid" aesthetic:
        
        // 1. Border: A subtle white ring simulates light catching the edge
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.white.withAlphaComponent(0.3).cgColor
        
        // 2. Background Tint: Adds a tiny bit of "milky" color to the glass
        // (We apply this to the view's background color with very low alpha)
        self.backgroundColor = UIColor.white.withAlphaComponent(0.05)
        
        // 3. Shadow: Liquid drops cast soft, colored shadows, not black ones
        self.layer.shadowColor = UIColor.white.cgColor
        self.layer.shadowOpacity = 0.1
        self.layer.shadowRadius = 12
        self.layer.shadowOffset = .zero
        self.layer.masksToBounds = false // Allow shadow to spill out
        effectView.layer.masksToBounds = true // Keep blur inside the corners
    }
    
    // This ensures the shadow/border updates if you resize in Storyboard
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius).cgPath
    }
}
