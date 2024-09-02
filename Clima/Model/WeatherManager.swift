//
//  WeatherManager.swift
//  Clima
//
//  Created by aelabass on 1/9/2024.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=&units=metric"
    
    
    func fetchWeather(cityName: String){
        let urlS = "\(weatherURL)&q=\(cityName)"
        performRequest(urlS)
    }
    
    func performRequest(_ urlS: String){
        if let url = URL(string:urlS){
            // start session
            let urlSession = URLSession(configuration: .default)
            // url task
            let task = urlSession.dataTask(with: url, completionHandler: {(data: Data?, response: URLResponse?, error: Error?) -> Void in
                if error != nil {
                    print(error!)
                    return
                }
                if let safeData = data {
                    let dataString = String(data:safeData, encoding:.utf8)
                    parseJSON(weatherData: safeData)
                }
                
            })
            // start
            task.resume()
            
        }
        
    }
    func parseJSON(weatherData: Data){
        let decoder = JSONDecoder()
        do {
            let decoderData = try decoder.decode(WeatherData.self, from: weatherData)
            print(decoderData.weather[0].description)
        }catch{
            print(error)
        }
    }
    
}
