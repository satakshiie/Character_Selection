//
//  ViewController.swift
//  Exertia
//
//  Created by satakshi on 06/11/25.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var caracterTitle: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var characterImageView: UIImageView!
    
    @IBOutlet weak var textView: UITextView!
    
    let characterImages = ["character1", "character2", "character3", "character4", "character5", "character6"]
    let characterNames = ["UNIT R-01", "UNIT R-02", "UNIT R-03", "UNIT R-04", "UNIT R-05", "UNIT R-06"]
    var selectedCharacterIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CharacterCell")
        
        // Make collection view background transparent and disable scrolling
        collectionView.backgroundColor = UIColor.clear
        collectionView.isScrollEnabled = false
        
        // Configure collection view layout for 3 columns
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumInteritemSpacing = 8
            layout.minimumLineSpacing = 8
            layout.sectionInset = UIEdgeInsets(top: 8, left: 5, bottom: 8, right: 5)
        }
        
        titleLabel.font = UIFont(name: "Audiowide-Regular", size: 30)
        titleLabel.text = "Choose Your Player"
        titleLabel.textColor = UIColor(named: "TitleColor")
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.adjustsFontSizeToFitWidth = true
        
        // Configure main character image view for consistent sizing
        characterImageView.contentMode = .scaleAspectFit
        characterImageView.clipsToBounds = true
        
        caracterTitle.font = UIFont(name: "Audiowide-Regular", size: 30)
        caracterTitle.text = "UNIT R-01"
        caracterTitle.textColor = UIColor(named: "TitleColor")
        caracterTitle.textAlignment = .center
        caracterTitle.numberOfLines = 1
      
        textView.backgroundColor = UIColor.clear
        textView.textColor = UIColor(named: "TitleColor")
        textView.text = "Lorem ipsum dolor sit er elit lame...la la la im so tired"
        textView.font = UIFont(name: "Audiowide-Regular", size: 16)
        // Do any additional setup after loading the view.
    }
    
    // MARK: - UICollectionViewDataSource

    // 1. Return the total number of items to display
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characterImages.count
    }

    // 2. Configure and return the cell for each item
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCell", for: indexPath)
        
        // Important: Remove previous subviews before adding a new one (prevents image layering)
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        
        // Programmatically add and configure an UIImageView for the character icon
        let imageView = UIImageView(frame: cell.contentView.bounds)
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        let imageName = characterImages[indexPath.item]
        imageView.image = UIImage(named: imageName)
        
        // Set cell background color to #7b1f6f
        cell.contentView.backgroundColor = UIColor(red: 0x7b/255.0, green: 0x1f/255.0, blue: 0x6f/255.0, alpha: 1.0)
        
        // Add border to the cell - highlight selected cell
        if indexPath.item == selectedCharacterIndex {
            // Selected cell - thicker golden border
            cell.contentView.layer.borderWidth = 4.0
            cell.contentView.layer.borderColor = UIColor(named: "TitleColor")?.cgColor ?? UIColor.yellow.cgColor
        } else {
            // Unselected cell - thin border
            cell.contentView.layer.borderWidth = 2.0
            cell.contentView.layer.borderColor = UIColor(named: "TitleColor")?.withAlphaComponent(0.6).cgColor ?? UIColor.white.withAlphaComponent(0.6).cgColor
        }
        
        cell.contentView.layer.cornerRadius = 8.0
        cell.contentView.layer.masksToBounds = true
        
        cell.contentView.addSubview(imageView)

        return cell
    }

    // MARK: - UICollectionViewDelegateFlowLayout
    
    // 3. Set the size for each cell to create a 3-column grid that fits within the collection view
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let spacing = layout.minimumInteritemSpacing
        let insets = layout.sectionInset
        
        // Calculate width for 3 columns with proper spacing
        let totalHorizontalSpacing = (spacing * 2) + insets.left + insets.right
        let availableWidth = collectionView.bounds.width - totalHorizontalSpacing
        let cellWidth = floor(availableWidth / 3)
        
        // Calculate height for 2 rows to fit within collection view height
        let totalVerticalSpacing = layout.minimumLineSpacing + insets.top + insets.bottom
        let availableHeight = collectionView.bounds.height - totalVerticalSpacing
        let cellHeight = floor(availableHeight / 2)
        
        // Make cells slightly wider by using full calculated width
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    // MARK: - UICollectionViewDelegate
    
    // 4. Handle cell selection to change main character
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedCharacterIndex = indexPath.item
        
        // Update main character image with consistent sizing
        let selectedCharacter = characterImages[selectedCharacterIndex]
        characterImageView.image = UIImage(named: selectedCharacter)
        
        // Ensure consistent content mode for all characters
        characterImageView.contentMode = .scaleAspectFit
        
        // Apply different scaling: character1 stays normal, others get 30% bigger
        let baseScale: CGFloat = 1.0
        let enlargedScale: CGFloat = 1.30
        
        if selectedCharacterIndex == 0 {
            // character1 - keep original size
            characterImageView.transform = CGAffineTransform(scaleX: baseScale, y: baseScale)
        } else {
            // character2-6 - increase by 15%
            characterImageView.transform = CGAffineTransform(scaleX: enlargedScale, y: enlargedScale)
        }
        
        // Update character name
        caracterTitle.text = characterNames[selectedCharacterIndex]
        
        // Optional: Add selection animation
        UIView.animate(withDuration: 0.3) {
            // Temporary scale up for animation
            if self.selectedCharacterIndex == 0 {
                self.characterImageView.transform = CGAffineTransform(scaleX: baseScale * 1.1, y: baseScale * 1.1)
            } else {
                self.characterImageView.transform = CGAffineTransform(scaleX: enlargedScale * 1.1, y: enlargedScale * 1.1)
            }
        } completion: { _ in
            UIView.animate(withDuration: 0.2) {
                // Return to appropriate final scale
                if self.selectedCharacterIndex == 0 {
                    self.characterImageView.transform = CGAffineTransform(scaleX: baseScale, y: baseScale)
                } else {
                    self.characterImageView.transform = CGAffineTransform(scaleX: enlargedScale, y: enlargedScale)
                }
            }
        }
        
        // Reload collection view to update cell selection states
        collectionView.reloadData()
    }
    @IBAction func customiseBackButtonTapped(_ sender: Any) {
        self.dismiss(animated: true)
    }
}







