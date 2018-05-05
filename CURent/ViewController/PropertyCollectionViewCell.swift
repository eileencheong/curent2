//
//  PropertyCollectionViewCell.swift
//  CURent
//
//  Created by Jaewon Sim on 4/28/18.
//  Copyright © 2018 CURent. All rights reserved.
//

import UIKit

class PropertyCollectionViewCell: UICollectionViewCell {
    var propertyImageView: UIImageView!
    var propertyNameLabel: UILabel!
    var propertyLocationLabel: UILabel!
    var propertyPriceLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        propertyImageView = UIImageView()
        propertyImageView.layer.cornerRadius = 10
        propertyImageView.clipsToBounds = true
        propertyImageView.contentMode = .scaleAspectFill
        propertyImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(propertyImageView)
        
        propertyNameLabel = UILabel()
        propertyNameLabel.font = UIFont.boldSystemFont(ofSize: 14)
        propertyNameLabel.textColor = .black
        propertyNameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(propertyNameLabel)
        
        propertyLocationLabel = UILabel()
        propertyLocationLabel.font = UIFont.systemFont(ofSize: 10)
        propertyLocationLabel.textColor = .gray
        propertyLocationLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(propertyLocationLabel)
        
        propertyPriceLabel = UILabel()
        propertyPriceLabel.font = UIFont.boldSystemFont(ofSize: 18)
        propertyPriceLabel.textColor = .white
        propertyPriceLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(propertyPriceLabel)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        NSLayoutConstraint.activate([
            propertyImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            propertyImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            propertyImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            propertyImageView.bottomAnchor.constraint(equalTo: contentView.topAnchor, constant: 88)
            ])
        
        NSLayoutConstraint.activate([
            propertyNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            propertyNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            propertyNameLabel.topAnchor.constraint(equalTo: propertyImageView.bottomAnchor, constant: 8),
            propertyNameLabel.heightAnchor.constraint(equalToConstant: propertyNameLabel.intrinsicContentSize.height)
            ])
        
        NSLayoutConstraint.activate([
            propertyLocationLabel.leadingAnchor.constraint(equalTo: propertyNameLabel.leadingAnchor),
            propertyLocationLabel.trailingAnchor.constraint(equalTo: propertyNameLabel.trailingAnchor),
            propertyLocationLabel.topAnchor.constraint(equalTo: propertyNameLabel.bottomAnchor, constant: 2),
            propertyLocationLabel.heightAnchor.constraint(equalToConstant: propertyLocationLabel.intrinsicContentSize.height)
            ])
        
        NSLayoutConstraint.activate([
            propertyPriceLabel.widthAnchor.constraint(equalToConstant: propertyPriceLabel.intrinsicContentSize.width),
            propertyPriceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            propertyPriceLabel.topAnchor.constraint(equalTo: propertyImageView.topAnchor, constant: 4),
            propertyPriceLabel.heightAnchor.constraint(equalToConstant: propertyPriceLabel.intrinsicContentSize.height)
            ])
        
        super.updateConstraints()
    }
}
