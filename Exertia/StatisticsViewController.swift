//
//  StatisticsViewController.swift
//  Exertia
//
//  Created by satakshi on 09/11/25.
//

import UIKit

class StatisticsViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var dailyreportView: UIView!
    @IBOutlet weak var headingLabel: UILabel!
    
    @IBOutlet weak var lastSessionCardView: UIView!
    
    @IBOutlet weak var personalBestCardView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
          
        
        let gradientHeight: CGFloat = 150
        let gradientView = AnimatedGradientView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: gradientHeight))
        gradientView.autoresizingMask = [.flexibleWidth]
        view.insertSubview(gradientView, at: 0)
        
        nameLabel.text = "Satakshi"
        nameLabel.font = .systemFont(ofSize: 20, weight: .regular)
        nameLabel.textColor = .white
        nameLabel.alpha = 0.8
        
        headingLabel.font = .systemFont(ofSize: 24, weight: .light)
        

        dailyreportView.layer.cornerRadius = 20
        dailyreportView.clipsToBounds = true
      
        let cardCornerRadius: CGFloat = 20.0 // You can change this value

            lastSessionCardView.layer.cornerRadius = cardCornerRadius
            lastSessionCardView.clipsToBounds = true

            personalBestCardView.layer.cornerRadius = cardCornerRadius
            personalBestCardView.clipsToBounds = true
        
    }
    
}
