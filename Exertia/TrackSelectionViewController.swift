//
//  TrackSelectionViewController.swift
//  Exertia
//
//  Created on 10/11/25.
//

import UIKit

class TrackSelectionViewController: UIViewController {
    
    // MARK: - UI Properties
    
    private let backgroundImageView = UIImageView()
    private let backButton = UIButton(type: .system)
    private let chooseTitleLabel = UILabel()
    private let trackTitleLabel = UILabel()
    private let durationLabel = UILabel()
    private let durationTimeLabel = UILabel()
    private let durationUpButton = UIButton(type: .system)
    private let durationDownButton = UIButton(type: .system)
    private let caloriesLabel = UILabel()
    private let caloriesValueLabel = UILabel()
    private let caloriesUpButton = UIButton(type: .system)
    private let caloriesDownButton = UIButton(type: .system)
    private let startButton = UIButton(type: .system)
    
    private var trackCards: [UIView] = []
    
    // MARK: - Properties
    
    var selectedTrackIndex = 0
    var selectedDuration = 10 // in minutes
    var selectedCalories = 80 // Changed from 50 to match ratio
    
    let trackNames = ["Planet X", "Planet Y", "Warzone"]
    let trackImages = ["Track1", "Track2", "Track3"]
    
    // Ratio: 80 kcal per 10 minutes = 8 kcal per minute
    let caloriePerMinute: Double = 8.0
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup initial UI
        setupUI()
    }
    
    // MARK: - Setup
    
    private func setupUI() {
        // Remove all subviews from storyboard (if any)
        view.subviews.forEach { $0.removeFromSuperview() }
        
        view.backgroundColor = .black
        
        setupBackgroundImage()
        setupBackButton()
        setupTitleLabels()
        setupDurationSection()
        setupCaloriesSection()
        setupTrackCards()
        setupStartButton()
        
        updateDurationLabel()
        updateCaloriesLabel()
    }
    
    private func setupBackgroundImage() {
        backgroundImageView.image = UIImage(named: "Track1")
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.alpha = 0.4 // 80% opacity (was 0.2 before)
        backgroundImageView.clipsToBounds = true
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(backgroundImageView, at: 0) // Ensure it's at the back
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupBackButton() {
        backButton.setTitle("←", for: .normal)
        backButton.titleLabel?.font = .systemFont(ofSize: 32)
        backButton.tintColor = UIColor(red: 0.957, green: 0.878, blue: 0.702, alpha: 1.0)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        view.addSubview(backButton)
        
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            backButton.widthAnchor.constraint(equalToConstant: 40),
            backButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupTitleLabels() {
        // Choose Track Title
        chooseTitleLabel.text = "Choose Track"
        chooseTitleLabel.font = UIFont(name: "Audiowide-Regular", size: 24)
        chooseTitleLabel.textColor = UIColor(red: 0.957, green: 0.878, blue: 0.702, alpha: 1.0)
        chooseTitleLabel.textAlignment = .center
        chooseTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(chooseTitleLabel)
        
        // Track Title (Planet X)
        trackTitleLabel.text = "Planet X"
        trackTitleLabel.font = UIFont(name: "Audiowide-Regular", size: 48)
        trackTitleLabel.textColor = UIColor(red: 0.957, green: 0.878, blue: 0.702, alpha: 1.0)
        trackTitleLabel.textAlignment = .center
        trackTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(trackTitleLabel)
        
        NSLayoutConstraint.activate([
            chooseTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            chooseTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            chooseTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            chooseTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            trackTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            trackTitleLabel.topAnchor.constraint(equalTo: chooseTitleLabel.bottomAnchor, constant: 30),
            trackTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            trackTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
    
    private func setupDurationSection() {
        // Duration Label
        durationLabel.text = "Duration"
        durationLabel.font = UIFont(name: "Audiowide-Regular", size: 28)
        durationLabel.textColor = UIColor(red: 0.957, green: 0.878, blue: 0.702, alpha: 1.0)
        durationLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(durationLabel)
        
        // Duration Time Label
        durationTimeLabel.text = "00:10:00"
        durationTimeLabel.font = UIFont(name: "Audiowide-Regular", size: 36)
        durationTimeLabel.textColor = UIColor(red: 0.957, green: 0.878, blue: 0.702, alpha: 1.0)
        durationTimeLabel.textAlignment = .center
        durationTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(durationTimeLabel)
        
                // Up Button
        durationUpButton.setTitle("▲", for: .normal)
        durationUpButton.titleLabel?.font = .systemFont(ofSize: 28)
        durationUpButton.tintColor = UIColor(red: 0.957, green: 0.878, blue: 0.702, alpha: 1.0)
        durationUpButton.translatesAutoresizingMaskIntoConstraints = false
        durationUpButton.addTarget(self, action: #selector(durationUpTapped), for: .touchUpInside)
        view.addSubview(durationUpButton)
        
        // Down Button
        durationDownButton.setTitle("▼", for: .normal)
        durationDownButton.titleLabel?.font = .systemFont(ofSize: 28)
        durationDownButton.tintColor = UIColor(red: 0.957, green: 0.878, blue: 0.702, alpha: 1.0)
        durationDownButton.translatesAutoresizingMaskIntoConstraints = false
        durationDownButton.addTarget(self, action: #selector(durationDownTapped), for: .touchUpInside)
        view.addSubview(durationDownButton)
        
        NSLayoutConstraint.activate([
            durationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            durationLabel.topAnchor.constraint(equalTo: trackTitleLabel.bottomAnchor, constant: 30),
            
            durationTimeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            durationTimeLabel.topAnchor.constraint(equalTo: durationLabel.bottomAnchor, constant: 10),
            
            durationUpButton.leadingAnchor.constraint(equalTo: durationTimeLabel.trailingAnchor, constant: 30),
            durationUpButton.centerYAnchor.constraint(equalTo: durationTimeLabel.centerYAnchor, constant: -18),
            durationUpButton.widthAnchor.constraint(equalToConstant: 40),
            durationUpButton.heightAnchor.constraint(equalToConstant: 35),
            
            durationDownButton.leadingAnchor.constraint(equalTo: durationTimeLabel.trailingAnchor, constant: 30),
            durationDownButton.centerYAnchor.constraint(equalTo: durationTimeLabel.centerYAnchor, constant: 18),
            durationDownButton.widthAnchor.constraint(equalToConstant: 40),
            durationDownButton.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
    
    private func setupCaloriesSection() {
        // Calories Label
        caloriesLabel.text = "Minimum Calories"
        caloriesLabel.font = UIFont(name: "Audiowide-Regular", size: 28)
        caloriesLabel.textColor = UIColor(red: 0.957, green: 0.878, blue: 0.702, alpha: 1.0)
        caloriesLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(caloriesLabel)
        
        // Calories Value Label
        caloriesValueLabel.text = "80 Kcal"
        caloriesValueLabel.font = UIFont(name: "Audiowide-Regular", size: 36)
        caloriesValueLabel.textColor = UIColor(red: 0.957, green: 0.878, blue: 0.702, alpha: 1.0)
        caloriesValueLabel.textAlignment = .center
        caloriesValueLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(caloriesValueLabel)
        
                // Up Button
        caloriesUpButton.setTitle("▲", for: .normal)
        caloriesUpButton.titleLabel?.font = .systemFont(ofSize: 28)
        caloriesUpButton.tintColor = UIColor(red: 0.957, green: 0.878, blue: 0.702, alpha: 1.0)
        caloriesUpButton.translatesAutoresizingMaskIntoConstraints = false
        caloriesUpButton.addTarget(self, action: #selector(caloriesUpTapped), for: .touchUpInside)
        view.addSubview(caloriesUpButton)
        
        // Down Button
        caloriesDownButton.setTitle("▼", for: .normal)
        caloriesDownButton.titleLabel?.font = .systemFont(ofSize: 28)
        caloriesDownButton.tintColor = UIColor(red: 0.957, green: 0.878, blue: 0.702, alpha: 1.0)
        caloriesDownButton.translatesAutoresizingMaskIntoConstraints = false
        caloriesDownButton.addTarget(self, action: #selector(caloriesDownTapped), for: .touchUpInside)
        view.addSubview(caloriesDownButton)
        
        NSLayoutConstraint.activate([
            caloriesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            caloriesLabel.topAnchor.constraint(equalTo: durationTimeLabel.bottomAnchor, constant: 20),
            
            caloriesValueLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            caloriesValueLabel.topAnchor.constraint(equalTo: caloriesLabel.bottomAnchor, constant: 10),
            
            caloriesUpButton.leadingAnchor.constraint(equalTo: caloriesValueLabel.trailingAnchor, constant: 30),
            caloriesUpButton.centerYAnchor.constraint(equalTo: caloriesValueLabel.centerYAnchor, constant: -18),
            caloriesUpButton.widthAnchor.constraint(equalToConstant: 40),
            caloriesUpButton.heightAnchor.constraint(equalToConstant: 35),
            
            caloriesDownButton.leadingAnchor.constraint(equalTo: caloriesValueLabel.trailingAnchor, constant: 30),
            caloriesDownButton.centerYAnchor.constraint(equalTo: caloriesValueLabel.centerYAnchor, constant: 18),
            caloriesDownButton.widthAnchor.constraint(equalToConstant: 40),
            caloriesDownButton.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
    
    private func setupTrackCards() {
        let cardWidth: CGFloat = 340
        let cardSpacing: CGFloat = 10
        
        // Create exactly 3 track cards
        for i in 0..<3 {
            let card = createTrackCard(index: i)
            trackCards.append(card)
            view.addSubview(card)
            
            if i == 0 {
                // First card - position below calories section
                NSLayoutConstraint.activate([
                    card.topAnchor.constraint(equalTo: caloriesValueLabel.bottomAnchor, constant: 30),
                    card.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    card.widthAnchor.constraint(equalToConstant: cardWidth),
                    card.heightAnchor.constraint(equalToConstant: 100)
                ])
            } else {
                // Subsequent cards - position below previous card
                NSLayoutConstraint.activate([
                    card.topAnchor.constraint(equalTo: trackCards[i-1].bottomAnchor, constant: cardSpacing),
                    card.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                    card.widthAnchor.constraint(equalToConstant: cardWidth),
                    card.heightAnchor.constraint(equalToConstant: 90)
                ])
            }
        }
    }
    
    private func createTrackCard(index: Int) -> UIView {
        let card = UIView()
        card.translatesAutoresizingMaskIntoConstraints = false
        card.layer.cornerRadius = 20
        card.clipsToBounds = true
        
        // Set background color
        if index == 0 {
            card.backgroundColor = UIColor(red: 0.851, green: 0.769, blue: 0.620, alpha: 0.3)
        } else {
            card.backgroundColor = UIColor(red: 0.310, green: 0.243, blue: 0.431, alpha: 1.0)
        }
        
        // Add tap gesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(trackCardTapped(_:)))
        card.addGestureRecognizer(tapGesture)
        card.isUserInteractionEnabled = true
        card.tag = index
        
        // Track Image
        let imageView = UIImageView()
        imageView.image = UIImage(named: trackImages[index])
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 15
        imageView.translatesAutoresizingMaskIntoConstraints = false
        card.addSubview(imageView)
        
        // Track Name
        let nameLabel = UILabel()
        nameLabel.text = trackNames[index]
        nameLabel.font = UIFont(name: "Audiowide-Regular", size: 20)
        nameLabel.textColor = index == 0 ? UIColor(red: 0.957, green: 0.878, blue: 0.702, alpha: 1.0) : .white
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        card.addSubview(nameLabel)
        
        // Duration Label
        let durLabel = UILabel()
        durLabel.text = "Duration"
        durLabel.font = UIFont(name: "Audiowide-Regular", size: 16)
        durLabel.textColor = index == 0 ? UIColor(red: 0.957, green: 0.878, blue: 0.702, alpha: 1.0) : .white
        durLabel.translatesAutoresizingMaskIntoConstraints = false
        card.addSubview(durLabel)
        
        // Duration Value
        let durValue = UILabel()
        durValue.text = "00:00:00"
        durValue.font = UIFont(name: "Audiowide-Regular", size: 16)
        durValue.textColor = index == 0 ? UIColor(red: 0.957, green: 0.878, blue: 0.702, alpha: 1.0) : .white
        durValue.translatesAutoresizingMaskIntoConstraints = false
        card.addSubview(durValue)
        
        // Calories Label
        let calLabel = UILabel()
        calLabel.text = "Min. Calories"
        calLabel.font = UIFont(name: "Audiowide-Regular", size: 16)
        calLabel.textColor = index == 0 ? UIColor(red: 0.957, green: 0.878, blue: 0.702, alpha: 1.0) : .white
        calLabel.translatesAutoresizingMaskIntoConstraints = false
        card.addSubview(calLabel)
        
        // Calories Value
        let calValue = UILabel()
        calValue.text = "25Cal"
        calValue.font = UIFont(name: "Audiowide-Regular", size: 16)
        calValue.textColor = index == 0 ? UIColor(red: 0.957, green: 0.878, blue: 0.702, alpha: 1.0) : .white
        calValue.translatesAutoresizingMaskIntoConstraints = false
        card.addSubview(calValue)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 10),
            imageView.centerYAnchor.constraint(equalTo: card.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 120),
            imageView.heightAnchor.constraint(equalToConstant: 80),
            
            nameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 15),
            nameLabel.topAnchor.constraint(equalTo: card.topAnchor, constant: index == 0 ? 15 : 10),
            
            durLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 15),
            durLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            
            durValue.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 15),
            durValue.topAnchor.constraint(equalTo: durLabel.bottomAnchor, constant: 2),
            
            calLabel.leadingAnchor.constraint(equalTo: durLabel.trailingAnchor, constant: 10),
            calLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            
            calValue.leadingAnchor.constraint(equalTo: durValue.trailingAnchor, constant: 10),
            calValue.topAnchor.constraint(equalTo: calLabel.bottomAnchor, constant: 2)
        ])
        
        return card
    }
    
    private func setupStartButton() {
        startButton.setTitle("Start", for: .normal)
        startButton.titleLabel?.font = UIFont(name: "Audiowide-Regular", size: 24)
        startButton.backgroundColor = UIColor(red: 0.957, green: 0.878, blue: 0.702, alpha: 1.0)
        startButton.setTitleColor(UIColor(red: 0.310, green: 0.243, blue: 0.431, alpha: 1.0), for: .normal)
        startButton.layer.cornerRadius = 25
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        view.addSubview(startButton)
        
        // Position below the last track card (trackCards[2])
        NSLayoutConstraint.activate([
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.topAnchor.constraint(equalTo: trackCards[2].bottomAnchor, constant: 15),
            startButton.widthAnchor.constraint(equalToConstant: 150),
            startButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // MARK: - Actions
    
    @objc private func backButtonTapped() {
        // Navigate back
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func durationUpTapped() {
        selectedDuration += 5
        if selectedDuration > 120 {
            selectedDuration = 120 // Max 2 hours
        }
        updateDurationLabel()
        updateCaloriesFromDuration() // Auto-update calories
    }
    
    @objc private func durationDownTapped() {
        selectedDuration -= 5
        if selectedDuration < 5 {
            selectedDuration = 5 // Min 5 minutes
        }
        updateDurationLabel()
        updateCaloriesFromDuration() // Auto-update calories
    }
    
    @objc private func caloriesUpTapped() {
        selectedCalories += 10
        if selectedCalories > 960 {
            selectedCalories = 960 // Max calories (120 min * 8 kcal/min)
        }
        updateCaloriesLabel()
        updateDurationFromCalories() // Auto-update duration
    }
    
    @objc private func caloriesDownTapped() {
        selectedCalories -= 10
        if selectedCalories < 40 {
            selectedCalories = 40 // Min calories (5 min * 8 kcal/min)
        }
        updateCaloriesLabel()
        updateDurationFromCalories() // Auto-update duration
    }
    
    @objc private func trackCardTapped(_ gesture: UITapGestureRecognizer) {
        guard let card = gesture.view else { return }
        selectTrack(index: card.tag)
    }
    
    @objc private func startButtonTapped() {
        // Start the game with selected track, duration, and calories
        print("Starting game with:")
        print("Track: \(trackNames[selectedTrackIndex])")
        print("Duration: \(selectedDuration) minutes")
        print("Calories: \(selectedCalories) Kcal")
        
        // TODO: Navigate to game view controller
        // You can add segue or navigation logic here
    }
    
    // MARK: - Helper Methods
    
    private func updateDurationLabel() {
        // Convert minutes to HH:MM:SS format
        let hours = selectedDuration / 60
        let minutes = selectedDuration % 60
        durationTimeLabel.text = String(format: "%02d:%02d:00", hours, minutes)
    }
    
    private func updateCaloriesLabel() {
        caloriesValueLabel.text = "\(selectedCalories) Kcal"
    }
    
    // Update calories based on duration (8 kcal per minute)
    private func updateCaloriesFromDuration() {
        selectedCalories = Int(Double(selectedDuration) * caloriePerMinute)
        updateCaloriesLabel()
    }
    
    // Update duration based on calories (8 kcal per minute)
    private func updateDurationFromCalories() {
        selectedDuration = Int(Double(selectedCalories) / caloriePerMinute)
        // Ensure duration stays within bounds
        if selectedDuration < 5 {
            selectedDuration = 5
        } else if selectedDuration > 120 {
            selectedDuration = 120
        }
        updateDurationLabel()
    }
    
    private func selectTrack(index: Int) {
        selectedTrackIndex = index
        trackTitleLabel.text = trackNames[index]
        
        // Update background image
        backgroundImageView.image = UIImage(named: trackImages[index])
        
        // Update all cards appearance
        for (i, card) in trackCards.enumerated() {
            if i == index {
                // Selected card
                card.backgroundColor = UIColor(red: 0.851, green: 0.769, blue: 0.620, alpha: 0.3)
                updateCardTextColor(card: card, isSelected: true)
            } else {
                // Unselected cards
                card.backgroundColor = UIColor(red: 0.310, green: 0.243, blue: 0.431, alpha: 1.0)
                updateCardTextColor(card: card, isSelected: false)
            }
        }
    }
    
    private func updateCardTextColor(card: UIView, isSelected: Bool) {
        let color = isSelected ? UIColor(red: 0.957, green: 0.878, blue: 0.702, alpha: 1.0) : .white
        
        for subview in card.subviews {
            if let label = subview as? UILabel {
                label.textColor = color
            }
        }
    }
}
