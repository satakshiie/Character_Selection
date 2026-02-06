import UIKit

class CharacterCell: UICollectionViewCell {

    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var containerView: UIView!
    
    private let glossLayer = CAGradientLayer()
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.backgroundColor = .clear
        containerView.backgroundColor = .clear

        containerView.layer.cornerRadius = 20
        containerView.layer.cornerCurve = .continuous
        containerView.clipsToBounds = true
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowRadius = 6
        self.layer.shadowOpacity = 0.3
        self.clipsToBounds = false

        setupGlossLayer()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        glossLayer.frame = containerView.bounds

        if let blurView = containerView.subviews.first(where: { $0 is UIVisualEffectView }) {
            blurView.frame = containerView.bounds
        }
    }
    
    private func setupGlossLayer() {
        glossLayer.colors = [
            UIColor.white.withAlphaComponent(0.15).cgColor,
            UIColor.white.withAlphaComponent(0.0).cgColor
        ]
        glossLayer.startPoint = CGPoint(x: 0, y: 0)
        glossLayer.endPoint = CGPoint(x: 1, y: 1)
        glossLayer.cornerRadius = 20
        glossLayer.cornerCurve = .continuous
    }

    func configure(player: Player, isSelected: Bool) {
        thumbImageView.image = UIImage(named: player.thumbnailImageName)

        containerView.subviews.filter { $0 is UIVisualEffectView }.forEach { $0.removeFromSuperview() }
        glossLayer.removeFromSuperlayer()

        let blurStyle: UIBlurEffect.Style = isSelected ? .systemMaterialLight : .systemUltraThinMaterialDark
        let blurEffect = UIBlurEffect(style: blurStyle)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = containerView.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        containerView.insertSubview(blurView, at: 0)
        containerView.layer.insertSublayer(glossLayer, at: 1)
        if isSelected {
            containerView.layer.borderWidth = 2
            containerView.layer.borderColor = UIColor.cyan.cgColor

            self.layer.shadowColor = UIColor.cyan.cgColor
            self.layer.shadowRadius = 10
            self.layer.shadowOpacity = 0.6

            animateSelection()
            
        } else {
            containerView.layer.borderWidth = 1.0
            containerView.layer.borderColor = UIColor.white.withAlphaComponent(0.15).cgColor

            self.layer.shadowColor = UIColor.black.cgColor
            self.layer.shadowRadius = 5
            self.layer.shadowOpacity = 0.3
        }
    }

    func animateSelection() {
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseIn, animations: {
            self.transform = CGAffineTransform(scaleX: 0.92, y: 0.92)
        }) { _ in
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                self.transform = CGAffineTransform.identity
            }, completion: nil)
        }
    }
}
