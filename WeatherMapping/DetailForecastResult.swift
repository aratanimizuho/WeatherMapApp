//
//  DetailForecastResult.swift
//  WeatherMapping
//
//  Created by 荒谷瑞穂 on 2022/09/01.
//

import UIKit

class DetailForecastResult: UIViewController {
    var button:UIBarButtonItem!
    var Foreccast:Forecast!
    
    var dt_tx:UILabel!
    var icon:UILabel!
    var temptext:UILabel!
    var temp:UILabel!
    var humidtext:UILabel!
    var humid:UILabel!
    var windtext:UILabel!
    var wind:UILabel!
    var pressuretext:UILabel!
    var pressure:UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        button = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(click))
        navigationItem.leftBarButtonItem = button
        
        dt_tx=UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 0))
        dt_tx.font=dt_tx.font.withSize(20)
        dt_tx.translatesAutoresizingMaskIntoConstraints=false
        dt_tx.numberOfLines=0
        dt_tx.text=Foreccast.dt_txt
        self.view.addSubview(dt_tx)
        dt_tx.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive=true
        dt_tx.topAnchor.constraint(equalTo: self.view.topAnchor,constant: 40).isActive=true
        
        icon=UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 0))
        icon.font=icon.font.withSize(200)
        icon.text=Foreccast.getIconText()
        icon.translatesAutoresizingMaskIntoConstraints=false
        self.view.addSubview(icon)
        icon.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive=true
        icon.topAnchor.constraint(equalTo: dt_tx.bottomAnchor,constant: 30).isActive=true
        
        temptext=UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 0))
        temptext.font=temptext.font.withSize(20)
        temptext.text="気温"
        temptext.translatesAutoresizingMaskIntoConstraints=false
        self.view.addSubview(temptext)
        temptext.trailingAnchor.constraint(equalTo: self.view.centerXAnchor,constant: -50).isActive=true
        temptext.topAnchor.constraint(equalTo: icon.bottomAnchor,constant: 50).isActive=true
        
        temp=UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 0))
        temp.font=temp.font.withSize(20)
        temp.text=Foreccast.getFormattedTemp()
        temp.translatesAutoresizingMaskIntoConstraints=false
        self.view.addSubview(temp)
        temp.centerXAnchor.constraint(equalTo: temptext.centerXAnchor).isActive=true
        temp.topAnchor.constraint(equalTo: temptext.bottomAnchor,constant: 10).isActive=true
        
        humidtext=UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 0))
        humidtext.font=humidtext.font.withSize(20)
        humidtext.text="湿度"
        humidtext.translatesAutoresizingMaskIntoConstraints=false
        self.view.addSubview(humidtext)
        humidtext.leadingAnchor.constraint(equalTo: self.view.centerXAnchor,constant: 20).isActive=true
        humidtext.topAnchor.constraint(equalTo: temptext.topAnchor).isActive=true
        
        humid=UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 0))
        humid.font=humid.font.withSize(20)
        humid.text=Foreccast.getFormattedHumidity()
        humid.translatesAutoresizingMaskIntoConstraints=false
        self.view.addSubview(humid)
        humid.centerXAnchor.constraint(equalTo: humidtext.centerXAnchor).isActive=true
        humid.topAnchor.constraint(equalTo: humidtext.bottomAnchor,constant: 10).isActive=true
        
        windtext=UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 0))
        windtext.font=windtext.font.withSize(20)
        windtext.text="風向/風速"
        windtext.translatesAutoresizingMaskIntoConstraints=false
        self.view.addSubview(windtext)
        windtext.centerXAnchor.constraint(equalTo: temptext.centerXAnchor).isActive=true
        windtext.topAnchor.constraint(equalTo: temp.bottomAnchor,constant: 30).isActive=true
        
        wind=UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 0))
        wind.font=wind.font.withSize(20)
        wind.text=Foreccast.getWindDrection()+"/"+Foreccast.getWindSpeed()
        wind.translatesAutoresizingMaskIntoConstraints=false
        self.view.addSubview(wind)
        wind.centerXAnchor.constraint(equalTo: windtext.centerXAnchor).isActive=true
        wind.topAnchor.constraint(equalTo: windtext.bottomAnchor,constant: 10).isActive=true
        
        pressuretext=UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 0))
        pressuretext.font=pressuretext.font.withSize(20)
        pressuretext.text="気圧"
        pressuretext.translatesAutoresizingMaskIntoConstraints=false
        self.view.addSubview(pressuretext)
        pressuretext.centerXAnchor.constraint(equalTo: humidtext.centerXAnchor).isActive=true
        pressuretext.topAnchor.constraint(equalTo: humid.bottomAnchor,constant: 30).isActive=true
        
        pressure=UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 0))
        pressure.font=pressure.font.withSize(20)
        pressure.text=Foreccast.getFormattedPressure()
        pressure.translatesAutoresizingMaskIntoConstraints=false
        self.view.addSubview(pressure)
        pressure.centerXAnchor.constraint(equalTo: humidtext.centerXAnchor).isActive=true
        pressure.topAnchor.constraint(equalTo: pressuretext.bottomAnchor,constant: 10).isActive=true
        

        // Do any additional setup after loading the view.
    }
    @objc func click(_sender:Any){
        self.dismiss(animated: true)
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
