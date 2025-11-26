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
    
    // Completed Badges
    var completedBadges = ["First Run", "Comet Leap", "Social Voyager"]
    
    // In Progress Badges
    var inProgressBadges = ["Villan Destroyer", "Streak Master"]
    var inProgressBadgeProgress: [String: Float] = [
        "Villan Destroyer": 0.4,
        "Streak Master": 0.7
    ]
    
    // Merged Badge Data
    let badgeDescriptions: [String: String] = [
        "First Run": "Complete your first 1-kilometer",
        "Comet Leap": "Jump 100 times in a single run",
        "Social Voyager": "Invite a friend",
        "Villan Destroyer": "Use a total of 20 combo moves",
        "Streak Master": "Maintain a 7 days streak"
    ]
    
    let badgeImages: [String: String] = [
        "First Run": "gold",
        "Comet Leap": "silver",
        "Social Voyager": "bronze",
        "Villan Destroyer": "inprogress",
        "Streak Master": "silver"
    ]
    
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
        
        // Check and move completed badges
        updateCompletedBadges()
    }
    
    /// Check if any in-progress badges have 100% progress and move them to completed
    func updateCompletedBadges() {
        let completedBadgesThisSession = inProgressBadges.filter { badge in
            let progress = inProgressBadgeProgress[badge] ?? 0.0
            return progress >= 1.0
        }
        
        // Move completed badges to completed list
        for badge in completedBadgesThisSession {
            if !completedBadges.contains(badge) {
                completedBadges.append(badge)
                inProgressBadges.removeAll { $0 == badge }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isShowingCompleted {
            return completedBadges.count
        } else {
            return inProgressBadges.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BadgeCell", for: indexPath) as? BadgeSwiftTableViewCell else {
            return UITableViewCell()
        }
        
        if isShowingCompleted {
            // Completed Tab Data
            let badgeName = completedBadges[indexPath.row]
            cell.titleLabel.text = badgeName
            cell.subtitleLabel.text = badgeDescriptions[badgeName] ?? "Badge Unlocked!"
            cell.badgeIcon.image = UIImage(named: badgeImages[badgeName] ?? "gold")
            
            // Completed tab: show subtitle, hide progress bar, full opacity badge
            cell.subtitleLabel.isHidden = false
            cell.progressBar?.isHidden = true
            cell.progressPercentageLabel?.isHidden = true
            cell.badgeIcon.alpha = 1.0
        } else {
            // In Progress Tab Data
            let badgeName = inProgressBadges[indexPath.row]
            cell.titleLabel.text = badgeName
            cell.badgeIcon.image = UIImage(named: badgeImages[badgeName] ?? "gold")
            
            // In Progress tab: hide subtitle, show progress bar, reduced opacity badge
            cell.subtitleLabel.isHidden = true
            cell.progressBar?.isHidden = false
            cell.badgeIcon.alpha = 0.5
            
            // Set progress
            let progress = inProgressBadgeProgress[badgeName] ?? 0.5
            cell.progressBar?.progress = progress
            
            // Update percentage label
            let percentage = Int(progress * 100)
            cell.progressPercentageLabel?.text = "\(percentage)%"
            cell.progressPercentageLabel?.isHidden = false
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


