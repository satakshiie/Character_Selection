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
        

        dailyreportView.layer.cornerRadius = 12
        dailyreportView.clipsToBounds = true
      
        
        
    }
    
}
