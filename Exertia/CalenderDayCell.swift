//
//  CalenderDayCell.swift
//  Exertia
//
//  Created by Ekansh Jindal on 02/02/26.
//

import UIKit

class CalendarDayCell: UICollectionViewCell {
    let bgView = UIView()
    let dayLabel = UILabel()
    let iconImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        bgView.layer.cornerRadius = 16
        bgView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(bgView)
        
        dayLabel.font = .systemFont(ofSize: 10, weight: .bold)
        dayLabel.textColor = .lightGray
        dayLabel.textAlignment = .center
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(dayLabel)
        
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(iconImageView)
        
        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: contentView.topAnchor),
            bgView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            bgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            bgView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            dayLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            dayLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            iconImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            iconImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 22),
            iconImageView.heightAnchor.constraint(equalToConstant: 22)
        ])
    }
    
    func configure(date: Date, isToday: Bool, hasActivity: Bool) {
        let formatter = DateFormatter()
        formatter.dateFormat = "E"
        dayLabel.text = formatter.string(from: date).uppercased()
        
        if isToday {
            bgView.backgroundColor = UIColor.neonPink.withAlphaComponent(0.2)
            bgView.layer.borderWidth = 1
            bgView.layer.borderColor = UIColor.neonPink.cgColor
            dayLabel.textColor = .white
            iconImageView.image = UIImage(systemName: "medal.fill")
            iconImageView.tintColor = .neonPink
        } else if hasActivity {
            bgView.backgroundColor = UIColor.neonYellow.withAlphaComponent(0.1)
            bgView.layer.borderWidth = 0
            dayLabel.textColor = .white
            iconImageView.image = UIImage(systemName: "medal.fill")
            iconImageView.tintColor = .neonYellow
        } else {
            bgView.backgroundColor = .clear
            bgView.layer.borderWidth = 0
            dayLabel.textColor = .gray
            iconImageView.image = UIImage(systemName: "circle.fill")
            iconImageView.tintColor = UIColor.white.withAlphaComponent(0.1)
        }
    }
}
