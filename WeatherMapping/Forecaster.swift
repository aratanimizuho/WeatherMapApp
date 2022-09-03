//
//  Forecaster.swift
//  WeatherMapping
//
//  Created by 荒谷瑞穂 on 2022/08/26.
//

import UIKit
import CoreLocation

class Forecaster: NSObject {
    static func forecast(lat:String, lon:String,completion:@escaping (ForecastResult)->Void){
        
        let appID = ""
        let urlString = "https://api.openweathermap.org/data/2.5/forecast?lat=" +  lat + "&lon=" + lon + "&appid=" + appID
        guard let url = URL(string: urlString) else {
            print("URL error")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let jsonData = data else {
                print("JSON data error")
                return
            }
            
            
            do {
                let result:ForecastResult = try JSONDecoder().decode(ForecastResult.self, from: jsonData)
                completion(result)
            }catch let error{
                print(error)
            }
        }
        task.resume()
    }
}

struct ForecastResult: Codable{
    var list:[Forecast]
}

struct Forecast: Codable {
    var dt_txt:String
    var main:Main
    var weather:[Weather]
    var dt:Int
    var wind:Wind
    
    struct Main: Codable {
        var temp: Double
        var pressure : Int
        var humidity : Int
    }
    
    struct Wind:Codable{
        var speed:Double
        var deg : Int
        var gust : Double
    }
    
    struct Weather: Codable {
        var description: String
        var id: Int
        var main: String
    }
    
    func getFormattedTemp() -> String{
        return String(format: "%.1f ℃", main.temp-273.15)
    }
    
    func getFormattedPressure() -> String{
        return String(format: "%4d hPa", main.pressure)
    }
    
    func getFormattedHumidity() ->String{
        return String(format: "%4d ％", main.humidity)
    }
    
    func getDescription() -> String{
        return weather.count > 0 ? weather[0].description : "" // 三項演算子
    }
    func getWindSpeed()->String{
        return String(format: "%.1f m/s", wind.speed)
    }
    func getWindDrection()->String{
        switch wind.deg{
        case 0..<Int(22.5):return "北"
        case Int(22.5)..<Int(67.5): return"北東"
        case Int(67.5)..<Int(112.5):return"南東"
        case Int(112.5)..<Int(202.5):return "南"
        case Int(202.5)..<Int(247.5):return "南西"
        case Int(247.5)..<Int(292.5):return"西"
        case Int(292.5)..<Int(337.5):return"北西"
        case Int(337.5)..<360:return"北"
        default:
            return ""
        }
    }
    func getIconText() -> String {
        if weather.count == 0 {
            return ""
        }
        // 次を参考: https://openweathermap.org/weather-conditions
        switch weather[0].id {
        case 200..<300: return "⚡️"
        case 300..<400: return "🌫"
        case 500..<600: return "☔️"
        case 600..<700: return "⛄️"
        case 700..<800: return "🌪"
        case 800: return "☀️"
        case 801..<900: return "☁️"
        case 900..<1000: return "🌀"
        default: return "☁️"
        }
    }
    
    func getMain() -> String {
        return weather.count > 0 ? weather[0].main : ""
    }

}
