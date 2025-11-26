//
//  ProfileViewController.swift
//  Exertia
//
//  Created by satakshi on 25/11/25.
//

import UIKit

class ProfileViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var completedButton: UIButton!
    @IBOutlet weak var inProgressButton: UIButton!
    @IBOutlet weak var underlineCenterConstraint: NSLayoutConstraint!
    
    let badges = ["First Run", "Comet Leap", "Social Voyager"]
    var isShowingCompleted = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appearance = UINavigationBarAppearance()
                appearance.configureWithTransparentBackground()
                appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
                navigationController?.navigationBar.standardAppearance = appearance
                navigationController?.navigationBar.scrollEdgeAppearance = appearance
                navigationController?.navigationBar.tintColor = .white
                
                // 2. Connect the TableView Logic
                tableView.dataSource = self
                tableView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            if isShowingCompleted {
                // If on "Completed" tab, show all badges
                return badges.count
            } else {
                // If on "In Progress" tab, show nothing
                return 0
            }
        }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 1. Use the Identifier "BadgeCell" (What you typed in Storyboard Attributes)
        // 2. Cast it to 'BadgeSwiftTableViewCell' (The actual filename/class name)
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BadgeCell", for: indexPath) as? BadgeSwiftTableViewCell else {
            return UITableViewCell()
        }
    
        
        // Now you can access your outlets!
        let badgeName = badges[indexPath.row]
        

        cell.titleLabel.text = badgeName
                
                // 2. Set Description & Custom Image based on the Badge Name
                switch badgeName {
                case "First Run":
                    cell.subtitleLabel.text = "Complete your first 1-kilometer"
                    // REPLACE "badge_gold" with your actual asset name
                    cell.badgeIcon.image = UIImage(named: "gold")
                    
                case "Comet Leap":
                    cell.subtitleLabel.text = "Jump 100 times in a single run"
                    // REPLACE "badge_blue" with your actual asset name
                    cell.badgeIcon.image = UIImage(named: "silver")
                    
                case "Social Voyager":
                    cell.subtitleLabel.text = "Invite a friend"
                    // REPLACE "badge_purple" with your actual asset name
                    cell.badgeIcon.image = UIImage(named: "bronze")
                    
                default:
                    cell.subtitleLabel.text = "Badge Unlocked!"
                    cell.badgeIcon.image = UIImage(systemName: "star.circle.fill") // Fallback
                }
        cell.badgeIcon.tintColor = .clear
        cell.badgeIcon.contentMode = .scaleAspectFit
        return cell
    }
        
    @IBAction func tabTapped(_ sender: UIButton) {
            
            if sender == inProgressButton {
                // 1. Switch Logic
                isShowingCompleted = false // Hide data
                
                // 2. Move Slider & Colors
                underlineCenterConstraint.constant = 0
                inProgressButton.setTitleColor(.white, for: .normal)
                completedButton.setTitleColor(.lightGray, for: .normal)
                
            } else {
                // 1. Switch Logic
                isShowingCompleted = true // Show data
                
                // 2. Move Slider & Colors
                underlineCenterConstraint.constant = inProgressButton.frame.width
                inProgressButton.setTitleColor(.lightGray, for: .normal)
                completedButton.setTitleColor(.white, for: .normal)
            }
            
            // 3. Animate Slider
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
            
            // 4. REFRESH THE TABLE (Crucial Step!)
            // This forces the table to check the variable and run 'numberOfRowsInSection' again
            tableView.reloadData()
        }


    }


