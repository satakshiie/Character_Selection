//
//  ViewController.swift
//  Exertia
//
//  Created by satakshi on 06/11/25.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var caracterTitle: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CharacterCell")
        }
        
           titleLabel.font = UIFont(name: "Audiowide-Regular", size: 30)
           titleLabel.text = "Choose Your Player"
           titleLabel.textColor = UIColor(named: "TitleColor")
           titleLabel.textAlignment = .center
           titleLabel.numberOfLines = 0
           titleLabel.adjustsFontSizeToFitWidth = true
        
        
        caracterTitle.font = UIFont(name: "Audiowide-Regular", size:40)
        caracterTitle.textColor = UIColor(named: "TitleColor")
        caracterTitle.textAlignment = .center
      
        textView.backgroundColor = UIColor.clear
        textView.textColor = UIColor(named: "TitleColor")
        textView.text = "Lorem ipsum dolor sit er elit lame...la la la im so tired"
        textView.font = UIFont(name: "Audiowide-Regular", size: 16)
        // Do any additional setup after loading the view.
    }
let characterImages = ["robot_bunny_icon", "orange_mech_icon", "blue_warrior_icon", "purple_ninja_icon", "green_astro_icon", "blue_player2_icon"]

    // MARK: - UICollectionViewDataSource

    // 1. Return the total number of items to display
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characterImages.count
    }

    // 2. Configure and return the cell for each item
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCell", for: indexPath)
        
        // Programmatically add and configure an UIImageView for the character icon
        let imageView = UIImageView(frame: cell.contentView.bounds)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        
        let imageName = characterImages[indexPath.item]
        imageView.image = UIImage(named: imageName)

        // Important: Remove previous subviews before adding a new one (prevents image layering)
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        cell.contentView.addSubview(imageView)

        return cell
    }



