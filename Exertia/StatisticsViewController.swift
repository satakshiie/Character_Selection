//
//  StatisticsViewController.swift
//  Exertia
//
//  Created by satakshi on 09/11/25.
//

import UIKit

class StatisticsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
          
        
        let gradientHeight: CGFloat = 150  // Adjust between 450-550 for your preference
        let gradientView = AnimatedGradientView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: gradientHeight))
        gradientView.autoresizingMask = [.flexibleWidth]
        view.insertSubview(gradientView, at: 0)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
