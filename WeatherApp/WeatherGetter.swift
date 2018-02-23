//
//  WeatherGetter.swift
//  WeatherApp
//
//  Created by Janardhan on 23/02/18.
//  Copyright © 2018 RanganathPavan. All rights reserved.
//

import Foundation
import Alamofire
class WeatherGetter {
    //weather getter 
//    fileprivate let openWeatherMapBaseURL = "http://api.openweathermap.org/data/2.5/weather"
//    fileprivate let openWeatherMapAPIKey = "534426267d3ae8ba9be00ba92eb2684a"
//    
//    func getWeather(_ city: String) {
//        
//        // This is a pretty simple networking task, so the shared session will do.
//        let session = URLSession.shared
//        
//        let weatherRequestURL = URL(string: "\(openWeatherMapBaseURL)?APPID=\(openWeatherMapAPIKey)&q=\(city)")!
//        
//        // The data task retrieves the data.
//        let dataTask = session.dataTask(with: weatherRequestURL, completionHandler: {
//            (data: Data?, response: URLResponse?, error: NSError?) in
//            if let error = error {
//                // Case 1: Error
//                // We got some kind of error while trying to get data from the server.
//                print("Error:\n\(error)")
//            }
//            else {
//                // Case 2: Success
//                // We got a response from the server!
//                do {
//                    // Try to convert that data into a Swift dictionary
//                    let weather = try JSONSerialization.jsonObject(
//                        with: data!,
//                        options: .mutableContainers) as! [String: AnyObject]
//                    
//                    // If we made it to this point, we've successfully converted the
//                    // JSON-formatted weather data into a Swift dictionary.
//                    // Let's print its contents to the debug console.
//                    print("Date and time: \(weather["dt"]!)")
//                    print("City: \(weather["name"]!)")
//                    
//                    print("Longitude: \(weather["coord"]!["lon"]!!)")
//                    print("Latitude: \(weather["coord"]!["lat"]!!)")
//                    
////                    print("Weather ID: \(weather["weather"]![0]!["id"]!!)")
////                    print("Weather main: \(weather["weather"]![0]!["main"]!!)")
////                    print("Weather description: \(weather["weather"]![0]!["description"]!!)")
////                    print("Weather icon ID: \(weather["weather"]![0]!["icon"]!!)")
//                    
//                    print("Temperature: \(weather["main"]!["temp"]!!)")
//                    print("Humidity: \(weather["main"]!["humidity"]!!)")
//                    print("Pressure: \(weather["main"]!["pressure"]!!)")
//                    
//                    print("Cloud cover: \(weather["clouds"]!["all"]!!)")
//                    
//                    print("Wind direction: \(weather["wind"]!["deg"]!!) degrees")
//                    print("Wind speed: \(weather["wind"]!["speed"]!!)")
//                    
//                    print("Country: \(weather["sys"]!["country"]!!)")
//                    print("Sunrise: \(weather["sys"]!["sunrise"]!!)")
//                    print("Sunset: \(weather["sys"]!["sunset"]!!)")
//                }
//                catch let jsonError as NSError {
//                    // An error occurred while trying to convert the data into a Swift dictionary.
//                    print("JSON error description: \(jsonError.description)")
//                }
//            }
//            } as! (Data?, URLResponse?, Error?) -> Void) 
//        
//        // The data task is set up...launch it!
//        dataTask.resume()
//    }
    
    
    public var url:URL?
    private var _date: Double?
    private var _temp: String?
    private var _location: String?
    private var _weather: String?
    typealias JSONStandard = Dictionary<String, AnyObject>
    
    
    func getWeather(_ city: String) {
        url = URL(string: "http://api.openweathermap.org/data/2.5/weather?appid=534426267d3ae8ba9be00ba92eb2684a&q=\(city)")!
    }
    
    var date: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let date = Date(timeIntervalSince1970: _date!)
        return (_date != nil) ? "Today, \(dateFormatter.string(from: date))" : "Date Invalid"
    }
    
    var temp: String {
        return _temp ?? "0 °C"
    }
    
    var location: String {
        return _location ?? "Location Invalid"
    }
    
    var weather: String {
        return _weather ?? "Weather Invalid"
    }
    
    func downloadData(completed: @escaping ()-> ()) {
        
        Alamofire.request(url!).responseJSON(completionHandler: {
            response in
            let result = response.result
            print(result)
            if let dict = result.value as? JSONStandard, let main = dict["main"] as? JSONStandard, let temp = main["temp"] as? Double, let weatherArray = dict["weather"] as? [JSONStandard], let weather = weatherArray[0]["main"] as? String, let name = dict["name"] as? String, let sys = dict["sys"] as? JSONStandard, let country = sys["country"] as? String, let dt = dict["dt"] as? Double {
                
                self._temp = String(format: "%.0f °C", temp - 273.15)
                self._weather = weather
                self._location = "\(name), \(country)"
                self._date = dt
            }
            
            completed()
        })
    }
    
    
}
