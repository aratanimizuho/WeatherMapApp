//
//  CustomUpperUIView.swift
//  WeatherMapping
//
//  Created by 荒谷瑞穂 on 2022/08/29.
//

import UIKit

class CustomUpperUIView: UIView{
    
    static let timeLabelFrame = CGRect(x: 0, y: 0, width: 300, height: 0)
    let timeLabel = UILabel(frame: CustomUpperUIView.timeLabelFrame)
    
    static let adressLabelFrame = CGRect(x: 0, y: 0, width: 300, height: 0)
    let adressLabel = UILabel(frame: CustomUpperUIView.adressLabelFrame)
    
    static let iconLabelFrame = CGRect(x: 0, y: 0, width: 300, height: 0)
    let iconLabel = UILabel(frame: CustomUpperUIView.iconLabelFrame)
    
    override init(frame :CGRect){
        super.init(frame: frame)
        
        adressLabel.font=adressLabel.font.withSize(20)
        self.addSubview(adressLabel)
        self.bringSubviewToFront(adressLabel)
        
        timeLabel.font = timeLabel.font.withSize(20)
        self.addSubview(timeLabel)
        
        iconLabel.font = iconLabel.font.withSize(100)
        self.addSubview(iconLabel)
        
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        iconLabel.translatesAutoresizingMaskIntoConstraints=false
        adressLabel.translatesAutoresizingMaskIntoConstraints=false
        
        timeLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive=true
        timeLabel.topAnchor.constraint(equalTo: adressLabel.bottomAnchor, constant: 10).isActive=true
        
        adressLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive=true
        adressLabel.topAnchor.constraint(equalTo: self.topAnchor,constant: 20).isActive=true
        
        iconLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive=true
        iconLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor,constant: 20).isActive=true
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
