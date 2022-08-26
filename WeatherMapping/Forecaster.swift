//
//  Forecaster.swift
//  WeatherMapping
//
//  Created by 荒谷瑞穂 on 2022/08/26.
//

import UIKit

class Forecaster: NSObject {
    static func forecast(cityName:String, completion:@escaping (ForecastResult)->Void){
        
        let appID = "a8a5d4e220b341ef92a135f4ce973bde"
        let urlString = "http://api.openweathermap.org/data/2.5/forecast?units=metric&q=" + cityName + "&APPID=" + appID
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
    
    struct Main: Codable {
        var temp: Double
        var pressure : Int
        var humidity : Int
    }
    
    struct Weather: Codable {
        var description: String
        var id: Int
        var main: String
    }
    
    func getFormattedTemp() -> String{
        return String(format: "%.1f ℃", main.temp)
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
