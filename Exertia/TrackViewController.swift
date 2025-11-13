//
//  TrackViewController.swift
//  Exertia
//
//  Created by admin62 on 13/11/25.
//

import UIKit

class TrackViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var trackTitleLabel: UILabel!
    @IBOutlet weak var durationValueLabel: UILabel!
    @IBOutlet weak var caloriesValueLabel: UILabel!
    @IBOutlet weak var trackTableView: UITableView!
    
    // MARK: - Properties
    var tracks: [Track] = []
    var selectedTrack: Track? {
        return tracks.first { $0.isSelected }
    }
    var userTimeAndCalories = TimeAndCalories(minutes: 10) // User's selected time (10 minutes default)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialize tracks
        tracks = TrackManager.shared.createDefaultTracks()
        
        // Debug: Print available fonts to check if Audiowide is installed
        #if DEBUG
        if UIFont(name: "Audiowide-Regular", size: 12) == nil {
            print("⚠️ Audiowide-Regular font not found!")
            print("Available font families:")
            for family in UIFont.familyNames.sorted() {
                print("- \(family)")
                for name in UIFont.fontNames(forFamilyName: family) {
                    print("  - \(name)")
                }
            }
        } else {
            print("✅ Audiowide-Regular font is available")
        }
        #endif
        
        // Register the XIB with correct name
        let nib = UINib(nibName: "TrackSelectionCellTableViewCell", bundle: nil)
        trackTableView.register(nib, forCellReuseIdentifier: "TrackCell")
        
        trackTableView.delegate = self
        trackTableView.dataSource = self
        trackTableView.isScrollEnabled = false
        trackTableView.separatorStyle = .none
        trackTableView.backgroundColor = .clear
        
        updateUI()
    }
    
    // MARK: - Actions
    @IBAction func backButtonTapped(_ sender: UIButton) {
        // Handle back button action
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        // Handle start button action
        guard let selected = selectedTrack else { return }
        print("Starting track: \(selected.displayName)")
        print("Duration: \(userTimeAndCalories.formattedDuration)")
        print("Min Calories: \(userTimeAndCalories.formattedCalories)")
    }
    
    @IBAction func durationUpTapped(_ sender: UIButton) {
        userTimeAndCalories.duration += 60 // Add 1 minute
        updateUI()
    }
    
    @IBAction func durationDownTapped(_ sender: UIButton) {
        if userTimeAndCalories.duration > 60 {
            userTimeAndCalories.duration -= 60 // Subtract 1 minute
            updateUI()
        }
    }
    
    @IBAction func caloriesUpTapped(_ sender: UIButton) {
        // Increase calories by 5, duration will auto-sync
        let newCalories = userTimeAndCalories.calories + 5
        userTimeAndCalories.setCalories(newCalories)
        updateUI()
    }
    
    @IBAction func caloriesDownTapped(_ sender: UIButton) {
        let newCalories = userTimeAndCalories.calories - 5
        if newCalories > 5 {
            userTimeAndCalories.setCalories(newCalories)
            updateUI()
        }
    }
    
    // MARK: - Helper Methods
    func updateUI() {
        // Update duration and calories labels
        durationValueLabel?.text = userTimeAndCalories.formattedDuration
        caloriesValueLabel?.text = userTimeAndCalories.formattedCalories
        
        // Update background and title for selected track
        if let selected = selectedTrack {
            backgroundImageView?.image = UIImage(named: selected.imageName)
            trackTitleLabel?.text = selected.displayName
        }
    }
}

// MARK: - UITableViewDataSource
extension TrackViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrackCell", for: indexPath) as! TrackSelectionCellTableViewCell
        
        let track = tracks[indexPath.row]
        cell.configure(
            trackName: track.displayName,
            trackImage: track.imageName,
            isSelected: track.isSelected
        )
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension TrackViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // All cells same height (reduced by 3%)
        return 107
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Update selection in data model
        let selectedTrackId = tracks[indexPath.row].trackId
        TrackManager.shared.updateSelection(for: selectedTrackId, in: &tracks)
        
        // Update UI
        updateUI()
        
        // Reload table to update cell appearances
        trackTableView.reloadData()
    }
}

