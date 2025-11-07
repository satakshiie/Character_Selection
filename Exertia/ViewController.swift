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
    
    @IBOutlet weak var textView: UITextView!
    
    let characterImages = ["character1", "character1", "character1", "character1", "character1", "character1"]
    
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
        
        // Add thin border to the cell
        cell.contentView.layer.borderWidth = 2.0
        cell.contentView.layer.borderColor = UIColor(named: "TitleColor")?.cgColor ?? UIColor.white.cgColor
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
}







