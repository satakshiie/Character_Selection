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
    
    let badges = ["First Run", "Comet Leap", "Social Voyager", "Galaxy Walker", "Marathon Star"]
    
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
            return badges.count
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
        cell.subtitleLabel.text = "Unlocked: \(badgeName)"
        
        // Set the icon
        cell.badgeIcon.image = UIImage(systemName: "medal.fill")
        cell.badgeIcon.tintColor = .systemYellow
        
        return cell
    }
        
        @IBAction func tabTapped(_ sender: UIButton) {
           
            
            if sender == inProgressButton {
                // Move Center to 0 (This means "Align exactly with Button 1's center")
                underlineCenterConstraint.constant = 0
                
                // Colors
                inProgressButton.setTitleColor(.white, for: .normal)
                completedButton.setTitleColor(.lightGray, for: .normal)
                
            } else {
                // Move Center to the Right by the width of the button
                // This lands it exactly in the center of Button 2
                underlineCenterConstraint.constant = inProgressButton.frame.width
                
                // Colors
                inProgressButton.setTitleColor(.lightGray, for: .normal)
                completedButton.setTitleColor(.white, for: .normal)
            }
            
            // Animate
            UIView.animate(withDuration: 0.3) {
                self.view.layoutIfNeeded()
            }
        }


    }


