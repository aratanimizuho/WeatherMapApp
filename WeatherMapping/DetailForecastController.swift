//
//  DetailForecastController.swift
//  WeatherMapping
//
//  Created by 荒谷瑞穂 on 2022/09/01.
//

import UIKit
class DetailForecastController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    var Dayforcasts:[Forecast]!
    
    var weatherTableView:UITableView!
    var weatherTableViewCell:UITableViewCell!
    var dt_text:UILabel!
    var icon:UILabel!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Dayforcasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DayForecastCell", for: indexPath)as! CustomListTableViewCell
        cell.nameLabel.text=Dayforcasts[indexPath.row].dt_txt.prefix(16).description
        cell.nameLabel.sizeToFit()
        
        cell.IconLabel.text = Dayforcasts[indexPath.row].getIconText()
        cell.IconLabel.sizeToFit()
        
        cell.tempLabel.text=Dayforcasts[indexPath.row].getFormattedTemp()
        cell.tempLabel.sizeToFit()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        let storyboard = UIStoryboard(name: "DetailForecastResult", bundle: nil)
        guard let viewController=storyboard.instantiateInitialViewController() as? DetailForecastResult else{return}
        let nav = UINavigationController(rootViewController: viewController)
        viewController.Foreccast=Dayforcasts[indexPath.row]
        showDetailViewController(nav, sender: DetailForecastController.self)
    }
    
    var button:UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(click))
        navigationItem.leftBarButtonItem = button
        
        weatherTableView=UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        
        weatherTableView.delegate=self
        weatherTableView.dataSource=self
        weatherTableView.register(CustomListTableViewCell.self, forCellReuseIdentifier: "DayForecastCell")

        self.view.addSubview(weatherTableView)

    }
    
    @objc func click(_sender:Any){
        self.dismiss(animated: true)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
