//
//  MultiplayerViewController.swift
//  Exertia
//
//  Created by Ekansh Jindal on 09/11/25.
//

import UIKit

struct Friend {
    var name: String
    var avatarImageName: String
    var isOnline: Bool
}

class MultiplayerViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var friendsTableView: UITableView!
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var idTextField: UITextField!
    
    @IBOutlet weak var addFriendPopupView: UIView!
    
    @IBAction func addFriendButtonTapped(_ sender: Any) {
        blurView.isHidden = false
        addFriendPopupView.isHidden = false
    }
    
    @IBAction func closeAddFriendTapped(_ sender: Any) {
        blurView.isHidden = true
        addFriendPopupView.isHidden = true
        
    }
    
    @IBOutlet weak var blurView: UIVisualEffectView!
    
    
    
    var onlineFriends: [Friend] = []
    var offlineFriends: [Friend] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        friendsTableView.dataSource = self
        friendsTableView.delegate = self
        // Do any additional setup after loading the view.
        let allFriends: [Friend] = [
                    Friend(name: "Ekansh", avatarImageName: "FriendPFP1", isOnline: true),
                    Friend(name: "Subodh", avatarImageName: "FriendPFP2", isOnline: true),
                    Friend(name: "Satakshi", avatarImageName: "FriendPFP3", isOnline: false),
                    Friend(name: "Ekansh 1", avatarImageName: "FriendPFP4", isOnline: true),
                    Friend(name: "Subodh 2", avatarImageName: "FriendPFP4", isOnline: false),
                    Friend(name: "Satakshi 2", avatarImageName: "FriendPFP5", isOnline: false),
                    Friend(name: "Satakshi 3", avatarImageName: "FriendPFP5", isOnline: true),
                ]
        onlineFriends = allFriends.filter { $0.isOnline }
        offlineFriends = allFriends.filter { !$0.isOnline }
        friendsTableView.backgroundColor = .clear
        addFriendPopupView.layer.cornerRadius = 23 // Or your desired radius
        addFriendPopupView.layer.masksToBounds = true
        addFriendPopupView.layer.borderWidth = 2
        addFriendPopupView.layer.borderColor = UIColor(hex: "#FFEFBE").cgColor
        styleTextField(usernameTextField)
        styleTextField(idTextField)
    }
    
    @IBAction func multiplayerBackButtonTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
            return 2 // 0 for Online, 1 for Offline
        }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            if section == 0 {
                return "Online Friends"
            } else {
                return "Offline Friends"
            }
        }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
            if let headerView = view as? UITableViewHeaderFooterView {
                headerView.textLabel?.font = UIFont(name: "Audiowide-Regular", size: 14) // Your custom font
                headerView.textLabel?.textColor = UIColor(hex: "FFEFBE")
            }
        }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return onlineFriends.count
        } else {
            return offlineFriends.count
        }
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            // This MUST match the identifier you set in the Storyboard ("FriendCell")
            let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as! FriendTableViewCell
            
            let friend: Friend
            
            if indexPath.section == 0 {
                // --- ONLINE SECTION ---
                friend = onlineFriends[indexPath.row]
                cell.statusIndicatorView.isHidden = false // SHOW the green dot
            } else {
                // --- OFFLINE SECTION ---
                friend = offlineFriends[indexPath.row]
                cell.statusIndicatorView.isHidden = true // HIDE the green dot
            }
            
            // Configure the rest of the cell
            cell.nameLabel.text = friend.name
            // !! Make sure you have images in Assets.xcassets named "avatar_1", "avatar_2" etc.
            cell.avatarImageView.image = UIImage(named: friend.avatarImageName)
            
            return cell
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            // You'll need to adjust this to match your cell's height + top/bottom margins
            // (80 for the cell + 16 for margins = 96)
            return 96
        }
        
    // Add this helper function to your class
        func styleTextField(_ textField: UITextField) {
            // --- 1. SETS THE FILL COLOR ---
            // (You can also set this in Storyboard)
            textField.backgroundColor = UIColor(hex: "#D9D9D9") // Your cream color
            
            // --- 2. SETS THE ROUNDED CORNERS ---
            textField.layer.cornerRadius = textField.frame.height / 2
            textField.layer.masksToBounds = true
            
            // --- 3. THIS IS THE NEW PART (ADDS THE BORDER) ---
            textField.layer.borderWidth = 2 // Sets the border thickness
            textField.layer.borderColor = UIColor(hex: "#FFFFFF").cgColor // Sets border color to white
            
            // --- 4. THIS ADDS PADDING ---
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
            textField.leftView = paddingView
            textField.leftViewMode = .always
            
            // --- 5. BONUS: STYLE THE PLACEHOLDER TEXT ---
            textField.attributedPlaceholder = NSAttributedString(
                string: textField.placeholder ?? "",
                attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray.withAlphaComponent(0.6)]
            )
            let placeholderColor = UIColor.gray.withAlphaComponent(0.6)
                    textField.attributedPlaceholder = NSAttributedString(
                        string: textField.placeholder ?? "",
                        attributes: [NSAttributedString.Key.foregroundColor: placeholderColor]
                    )
        }
    }
