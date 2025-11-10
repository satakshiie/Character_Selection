//
//  MultiplayerViewController.swift
//  Exertia
//
//  Created on 10/11/25.
//

import UIKit

class MultiplayerViewController: UIViewController {
    
    @IBOutlet weak var friendsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the table view if needed
        friendsTableView?.delegate = self
        friendsTableView?.dataSource = self
    }
    
    @IBAction func multiplayerBackButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension MultiplayerViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of friends
        return 0 // TODO: Update with actual data
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath)
        // Configure the cell
        // TODO: Update with actual data
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Handle friend selection
        // TODO: Implement selection logic
    }
}
