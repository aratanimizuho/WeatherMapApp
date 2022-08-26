//
//  Detail ViewController.swift
//  WeatherMapping
//
//  Created by 荒谷瑞穂 on 2022/08/26.
//

import UIKit

class Detail_ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    var forecasts = [Forecast]()
    var weatherTableView:UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherTableView=UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        
        self.view.addSubview(weatherTableView)

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastCell", for: indexPath)
        
        let timeLabel = cell.viewWithTag(1) as? UILabel
        timeLabel?.text = forecasts[indexPath.row].dt_txt
        
        let iconLabel = cell.viewWithTag(2) as? UILabel
        iconLabel?.text = forecasts[indexPath.row].getIconText()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "MainToDetail", sender: forecasts[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
