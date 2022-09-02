//
//  CustomListTableViewCell.swift
//  WeatherMapping
//
//  Created by 荒谷瑞穂 on 2022/08/28.
//

import UIKit

class CustomListTableViewCell: UITableViewCell {
    
    static let nameLabelFrame = CGRect(x: 10, y: 0, width: 300, height: 0)
    let nameLabel = UILabel(frame: CustomListTableViewCell.nameLabelFrame)
    
    let IconLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 0))
    
    let tempLabel=UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        nameLabel.numberOfLines = 0
        nameLabel.lineBreakMode = .byWordWrapping
        
        
        IconLabel.numberOfLines=0
        IconLabel.lineBreakMode = .byWordWrapping
        IconLabel.font=IconLabel.font.withSize(50)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        IconLabel.translatesAutoresizingMaskIntoConstraints=false
        
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(IconLabel)
        
        nameLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive=true
        nameLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 30).isActive=true
        
        IconLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor,constant: 30).isActive=true
        IconLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive=true
        
        tempLabel.numberOfLines=0
        tempLabel.frame=CGRect(x: 0, y: 100, width: self.contentView.frame.width, height: self.contentView.frame.width)
        tempLabel.lineBreakMode = .byWordWrapping
        tempLabel.textAlignment=NSTextAlignment.center
        tempLabel.translatesAutoresizingMaskIntoConstraints=false
        tempLabel.font=tempLabel.font.withSize(20)
        self.contentView.addSubview(tempLabel)
        
        tempLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor).isActive=true
        tempLabel.leadingAnchor.constraint(equalTo: IconLabel.trailingAnchor, constant: 10).isActive=true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
