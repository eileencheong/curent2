//
//  FilterCollectionViewCell.swift
//  CURent
//
//  Created by Eileen  Cheong on 5/1/18.
//  Copyright © 2018 CURent. All rights reserved.
//

import UIKit
import ChameleonFramework

class FilterCollectionViewCell: UICollectionViewCell {
    
    var filterLabel: UILabel!
    //var unselectedColor: UIColor = UIColor(red: 188/255, green: 188/255, blue: 188/255, alpha: 1.0)
    var unselectedColor: UIColor = UIColor(red: 0.88, green: 0.88, blue: 0.88, alpha: 1.0)
    var selectedColor: UIColor = HexColor("#003973")!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        filterLabel = UILabel(frame: bounds)
        filterLabel.textAlignment = .center
        filterLabel.font = .systemFont(ofSize: 14)
        filterLabel.textColor = .white
        layer.cornerRadius = 10
        //backgroundColor = UIColor(red: 188/255, green: 188/255, blue: 188/255, alpha: 1.0)
        backgroundColor = UIColor.lightGray
        contentView.addSubview(filterLabel)
        isSelected = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with title: String) {
        filterLabel.text = title
    }
    
    override var isSelected: Bool {
        didSet {
            super.isSelected = isSelected
            if isSelected {
                backgroundColor = selectedColor
                filterLabel.textColor = unselectedColor
            } else {
                backgroundColor = unselectedColor
                filterLabel.textColor = selectedColor
            }
            setNeedsDisplay()
        }
    }
    
}
