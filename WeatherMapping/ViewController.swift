//
//  ViewController.swift
//  WeatherMapping
//
//  Created by 荒谷瑞穂 on 2022/08/25.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController ,CLLocationManagerDelegate{
    
    var currentImage:[UILabel] = []
    var Mapview : MKMapView!
    var locationManager: CLLocationManager!
    var myILabel:UILabel!
    var myButton:UIButton!
    var adressLabel:UILabel!
    var weatherLabel:UILabel!
    let annotation = MKPointAnnotation()
    
    //住所の変数
    var adress:String = ""
    
    var EnAdress:String=""
//   使いません
//    var predx : CGFloat!
//    var predy : CGFloat!
//
//    var newdx : CGFloat!
//    var newdy : CGFloat!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Mapの設定
        Mapview=MKMapView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager!.requestWhenInUseAuthorization()
        
        locationManager.startUpdatingLocation()

        
        var region = MKCoordinateRegion()
        //中心位置をユーザの現在位置に設定
        region.center=Mapview.userLocation.coordinate
        region.span.latitudeDelta=0.02
        region.span.longitudeDelta=0.02
        Mapview.setRegion(region, animated: false)
        Mapview.mapType = .standard
        
        //ユーザの移動を追従する
        Mapview.userTrackingMode=MKUserTrackingMode.follow
        //ユーザの向いてる方向を記載する
        Mapview.userTrackingMode=MKUserTrackingMode.followWithHeading
        
        //ラベル追加
        let height = 100
        let mapkitheight=self.Mapview.frame.height
        let mapkitwidth=self.Mapview.frame.width
        myILabel=UILabel(frame: CGRect(x: 0, y: Int(mapkitheight)-height, width: Int(mapkitwidth), height: height))
        
        myILabel.text = adress
        myILabel.textAlignment = NSTextAlignment.left
        myILabel.backgroundColor = UIColor.white
        myILabel.textColor = UIColor.black
        myILabel.layer.masksToBounds = true
        myILabel.layer.cornerRadius = 40.0
        myILabel.isUserInteractionEnabled=true
        myILabel.numberOfLines = 0
        
        //ボタンの追加
        myButton=UIButton(type: .infoDark)
        myButton.frame=CGRect(x: 0, y: 0, width: height, height: height)
        myButton.layer.position=CGPoint(x: Int(self.view.frame.width)-height/2, y: Int(self.view.frame.height)-height/2)
        myButton.setImage(UIImage(named: "Button Mark.png"), for: .normal)
        myButton.setTitleColor(UIColor.black, for: .normal)
        //イベントの追加
        myButton.addTarget(self, action: #selector(self.onSenderViewController), for: .touchUpInside)
        
        //住所テキストの追加
        adressLabel = UILabel(frame: CGRect(x: 10, y:Int(self.view.frame.height)-(height+10), width: Int(self.view.frame.width)-(height+10), height: height))
        adressLabel.textColor=UIColor.black
        adressLabel.textAlignment = NSTextAlignment.left
        adressLabel.layer.masksToBounds = true
        
        //天気テキストの追加
        weatherLabel=UILabel(frame: CGRect(x: 10, y: Int(self.view.frame.height)-(height-10), width: Int(self.view.frame.width)-(height+10), height: height))
        adressLabel.textColor=UIColor.black
        adressLabel.textAlignment = NSTextAlignment.left
        adressLabel.layer.masksToBounds = true
        
        self.view.addSubview(Mapview)
        self.view.addSubview(myILabel)
        self.view.addSubview(myButton)
        self.view.bringSubviewToFront(myButton)
        self.view.addSubview(adressLabel)
        self.view.bringSubviewToFront(adressLabel)
        self.view.addSubview(weatherLabel)
        self.view.bringSubviewToFront(weatherLabel)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //タッチした場所の住所を読み取る
        let touch = touches.first
        guard let tappedPoint = touch?.location(in: self.view) else { return }
        let center = Mapview.convert(tappedPoint, toCoordinateFrom: Mapview)
        
        let lat = center.latitude
        let log = center.longitude
        
        convert(lat: lat, log: log)
        
        annotation.coordinate = CLLocationCoordinate2DMake(lat, log)
    }
    //touchbeganで読み取った緯度軽度から住所に変換する
    func convert(lat:CLLocationDegrees,log:CLLocationDegrees){
        
        // 住所から緯度経度に変換
        let geocoder = CLGeocoder()
        // 緯度経度から住所を作成
        let location = CLLocation(latitude: lat, longitude: log)
        // クロージャー（原則クロージャーの中に入ってるものは self を付けて書く。値が入ったあとにカッコ内が呼ばれ、値が入るまではカッコの外が呼ばれる）
        // 経度、緯度から逆ジオコーディングして住所を取得する
        geocoder.reverseGeocodeLocation(location){ [self]placeMark,error in
                if let placemark = placeMark?.first{
                    let Country = (placemark.country != nil) ? placemark.country : " "
                    let Provincial = (placemark.administrativeArea != nil) ? placemark.administrativeArea : " "
                    let City = (placemark.locality != nil) ? placemark.locality : " "
                    let name = (placemark.name != nil) ? placemark.name : " "
                    adress=Country!+":"+Provincial!+City!+name!
                    print(adress+": placemark success")
                    
                }else{
                    adress=""
                    print("placemark error :"+(error?.localizedDescription)! as Any)
                }
        }
        
        adressLabel.text=adress
            
        let Engeocoder = CLGeocoder()
        let Enlocation = CLLocation(latitude: lat, longitude: log)
        
        Engeocoder.reverseGeocodeLocation(Enlocation, preferredLocale: Locale.init(identifier: "en_US"),completionHandler: { [self] (placemark,error)->Void in
            if let pm = placemark?.first{
                
                if pm.locality != nil
                {
                
                EnAdress = pm.locality as Any as! String
                
                }else{
                    EnAdress = ""
                }
            }else{
                EnAdress = ""
            }
        })
        Weatherreport(lat: lat,log: log)
    }
    
    var forecastlist = [Forecast]()
    var weather:currentWeather!
    
    var data:Date!
    var icon:String=""
    var temp:String=""
    
    //letとlogから天気情報を取得
    func Weatherreport(lat:CLLocationDegrees,log:CLLocationDegrees){
        
        let Stlat = String(lat)
        let Stlog = String(log)
        
        data=Date()
        
        Weather.Weather(lat: Stlat, lon: Stlog){ [self](result) in
            weather=result
            let dt = result.dt
            icon = result.getIconText()
            temp = result.getFormattedTemp()
            data=NSDate(timeIntervalSince1970: TimeInterval(dt)) as Date
            
        }
                
        
        Forecaster.forecast(lat: Stlat, lon: Stlog){
            [self](result)in
            self.forecastlist=result.list
        }
        
        let df = DateFormatter()
        df.dateFormat="M/d H:mm"
        
        if icon != ""{
            self.weatherLabel.text = df.string(from: data)+"   :"+icon+"   :"+temp
        }
        
        //ピンを差す
        annotation.title=icon+":"+temp
        annotation.subtitle=df.string(from: data)
        
        Mapview.addAnnotation(annotation)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    //位置情報の許可
    func locationManager(_ manager: CLLocationManager,didChangeAuthorization status: CLAuthorizationStatus) {
            switch status {
            // 許可されてない場合
            case .notDetermined:
            // 許可を求める
                manager.requestWhenInUseAuthorization()
            // 拒否されてる場合
            case .restricted, .denied:
                // 何もしない
                break
            // 許可されている場合
            case .authorizedAlways, .authorizedWhenInUse:
                // 現在地の取得を開始
                manager.startUpdatingLocation()
                break
            default:
                break
            }
        }
    
    @objc func onSenderViewController(sender:UIButton){
        if adress==""{
            return
            
        }else{
            let storyboard = UIStoryboard(name: "DetailViewController", bundle: nil)
            guard let viewController=storyboard.instantiateInitialViewController() as? Detail_ViewController else{return}
            
            if forecastlist.count>0{
                viewController.forecasts=forecastlist
            }else{
                return;
            }
            viewController.currentWeather=weather
            viewController.adress=adress
            
            data=Date()
            let df = DateFormatter()
            df.dateFormat="M/d H:mm"
            viewController.date=df.string(from: data)
            
            let nav = UINavigationController(rootViewController: viewController)
            present(nav, animated: true)
        }
        
        
    }

}

