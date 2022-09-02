//
//  CustomCollectionViewCell.swift
//  WeatherMapping
//
//  Created by 荒谷瑞穂 on 2022/08/29.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    let nameLabel = UILabel()
    
    let iconlabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        nameLabel.numberOfLines = 0
        nameLabel.frame=CGRect(x: 0, y: 0, width: self.contentView.frame.width, height: 0)
        nameLabel.lineBreakMode = .byWordWrapping
        nameLabel.textAlignment=NSTextAlignment.center
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(nameLabel)
        
        nameLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive=true
        nameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 20).isActive=true
        
        iconlabel.numberOfLines=0
        iconlabel.lineBreakMode = .byWordWrapping
        iconlabel.font = iconlabel.font.withSize(20)
        iconlabel.translatesAutoresizingMaskIntoConstraints=false
        
        self.contentView.addSubview(iconlabel)
        
        iconlabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive=true
        iconlabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,constant: 10).isActive=true
        
    }
    
    required init(coder aDecoder:NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
