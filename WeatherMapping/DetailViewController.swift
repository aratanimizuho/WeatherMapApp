//
//  Detail ViewController.swift
//  WeatherMapping
//
//  Created by 荒谷瑞穂 on 2022/08/26.
//

import UIKit
import OrderedCollections

class Detail_ViewController: UIViewController,UITableViewDelegate, UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    //upperView
    var UpperView=CustomUpperUIView()
    var date:String!
    var adress:String!
    var Weather:[String]=[String]()
    let element:[String]=["気温","湿度","風向/風速","気圧"]
    
    //lowerView
    var weatherTableView:UITableView!
    var weatherTableViewCell:UITableViewCell!
    var dt_text:UILabel!
    var icon:UILabel!
    
    //data
    var forecasts = [Forecast]()
    var currentWeather:currentWeather!
    var weekforcasts = [Forecast]()
    var weekforecastsicon=[String]()
    var iconcount=[String:Int]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var button:UIBarButtonItem!
        
        button = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(click))
        navigationItem.leftBarButtonItem = button
        
        UpperView.frame=CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height/2-100)
        self.view.addSubview(UpperView)
        UpperView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive=true
        UpperView.timeLabel.text=date
        UpperView.adressLabel.text=adress
        UpperView.iconLabel.text=currentWeather.getIconText()
        
        Weather.append(currentWeather.getFormattedTemp())
        print(currentWeather.getTempmin())
        Weather.append(currentWeather.getFormattedHumidity())
        Weather.append(currentWeather.getWindDrection()+"/"+currentWeather.getWindSpeed())
        print(currentWeather.getWindSpeed())
        Weather.append(currentWeather.getFormattedPressure())
        
        let screensize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2)

        let Detail : UICollectionView = {
            let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()

            //各々の設計に合わせて調整
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 10
            layout.scrollDirection = .horizontal
            layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            layout.sectionInset = .init(top: 8, left: 0, bottom: 8, right: 0)

            let Detail = UICollectionView(frame: CGRect(x: 0, y: 200, width: screensize.width, height: 150), collectionViewLayout: layout)
            Detail.setCollectionViewLayout(layout, animated: true)

            return Detail
        }()

        Detail.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        Detail.dataSource=self
        Detail.delegate=self
        self.view.addSubview(Detail)

        Detail.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive=true
        Detail.topAnchor.constraint(equalTo: UpperView.iconLabel.bottomAnchor).isActive=true
        
        WeekForcast(forecasts: forecasts)
        weatherTableView=UITableView(frame: CGRect(x: 0, y: 300, width: self.view.frame.width, height: self.view.frame.height))
        weatherTableView.delegate=self
        weatherTableView.dataSource=self
        weatherTableView.register(CustomListTableViewCell.self, forCellReuseIdentifier: "ForecastCell")

        self.view.addSubview(weatherTableView)
        
        weatherTableView.topAnchor.constraint(equalTo: UpperView.bottomAnchor).isActive=true
        DispatchQueue.main.async { // メインスレッドで実行
            self.weatherTableView.reloadData()
        }

        // Do any additional setup after loading the view.
    }
    @objc func click(_sender:Any){
        self.dismiss(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weekforcasts.count
    }
    
    func WeekForcast(forecasts:[Forecast]){
        
        for i in 0...(forecasts.count-1){
            if i == 0 {
                weekforcasts.append(forecasts[0])
                iconcount.updateValue(1, forKey: forecasts[i].getIconText())
               
            }else if i == forecasts.count-1{
                //天気アイコンをカウントする
                CountIcon(dictionary: iconcount)
            }
            else{
                let originalDate = forecasts[i].dt_txt.prefix(10)
                let compareDate = forecasts[i-1].dt_txt.prefix(10)
                
                //天気アイコンを格納
                if originalDate == compareDate{
                    if iconcount.keys.contains(forecasts[i].getIconText()) == false{
                        iconcount.updateValue(1, forKey: forecasts[i].getIconText())
                        
                    }else{
                        if let countup = iconcount[forecasts[i].getIconText()]
                        {
                            iconcount.updateValue(countup+1, forKey: forecasts[i].getIconText())
                        }
                    }
                }
                
                if originalDate != compareDate{
                    weekforcasts.append(forecasts[i])
                    //天気アイコンをカウントする
                    CountIcon(dictionary: iconcount)
                    iconcount.updateValue(1, forKey: forecasts[i].getIconText())
                }
                
            }
        }
    }
    
    func DayForcast(Day:String,forecasts:[Forecast])->[Forecast]{
        var DayForcast=[Forecast]()
        for i in 0...(forecasts.count-1) {
            if forecasts[i].dt_txt.prefix(10)==Day{
                DayForcast.append(forecasts[i])
            }
        }
        return DayForcast
    }
    
    func CountIcon(dictionary:[String:Int]){
        if let maxvalue = dictionary.max(by: {a,b in a.value<b.value}){
            weekforecastsicon.append(maxvalue.key)
        }
        iconcount.removeAll()
    }
    func UNIXtoUTC(Unix:Int)->String{
        let data=NSDate(timeIntervalSince1970: TimeInterval(Unix)) as Date
        let df = DateFormatter()
        df.dateFormat="M/d"
        
        return df.string(from: data)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastCell", for: indexPath)as! CustomListTableViewCell
        cell.nameLabel.text=weekforcasts[indexPath.row].dt_txt.prefix(10).description
        cell.nameLabel.sizeToFit()
        
        cell.IconLabel.text = weekforecastsicon[indexPath.row]
        cell.IconLabel.sizeToFit()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dayforecasts:[Forecast]=DayForcast(Day: weekforcasts[indexPath.row].dt_txt.prefix(10).description, forecasts: forecasts)
        
        let storyboard = UIStoryboard(name: "DetailForecastController", bundle: nil)
        guard let viewController=storyboard.instantiateInitialViewController() as? DetailForecastController else{return}
        let nav = UINavigationController(rootViewController: viewController)
        viewController.Dayforcasts=dayforecasts
        showDetailViewController(nav, sender: Detail_ViewController.self)
        //present(viewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CustomCollectionViewCell
            
        cell.nameLabel.text = element[indexPath.row]
        cell.iconlabel.text=Weather[indexPath.row]
        cell.backgroundColor=UIColor.white
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return element.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UpperView.frame.width, height: UpperView.frame.height/2)
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
