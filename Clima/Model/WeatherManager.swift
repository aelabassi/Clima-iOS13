//
//  WeatherManager.swift
//  Clima
//
//  Created by aelabass on 1/9/2024.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    let weatherURL = "https://samples.openweathermap.org/data/2.5/find?units=metric"
    
    
    func fetchWeather(cityName: String){
        let urlS = "\(weatherURL)&q=\(cityName)"
        performRequest(urlS)
    }
    
    func performRequest(_ urlS: String){
        if let url = URL(string:urlS){
            // start session
            let urlSession = URLSession(configuration: .default)
            // url task
            let task = urlSession.dataTask(with: url, completionHandler: handler(data:reseponse:error:))
            // start
            task.resume()
            
        }
        
    }
    
    func handler(data: Data?, reseponse: URLResponse?, error: Error?){
        if error != nil {
            print(error!)
            return
        }
        if let safeData = data {
            let dataString = String(data:safeData, encoding:.utf8)
            print(dataString)
        }
    }
}
