//
//  WeatherManager.swift
//  Clima
//
//  Created by aelabass on 1/9/2024.
//  Copyright © 2024 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate{
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=units=metric"
    
    var delegate: WeatherManagerDelegate?
    func fetchWeather(cityName: String){
        let urlS = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlS)
    }
    
    func performRequest(with urlS: String){
        if let url = URL(string:urlS){
            // start session
            let urlSession = URLSession(configuration: .default)
            // url task
            let task = urlSession.dataTask(with: url, completionHandler: {(data: Data?, response: URLResponse?, error: Error?) -> Void in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(safeData){
                        self.delegate?.didUpdateWeather(self, weather: weather)
                        
                    }
                }
                
            })
            // start
            task.resume()
            
        }
        
    }
    func parseJSON(_ weatherData: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do {
            let decoderData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decoderData.weather[0].id
            let cityName = decoderData.name
            let temp = decoderData.main.temp
            let weather = WeatherModel(conditionId: id, cityName: cityName, temperature: temp)
            return weather
        }catch{
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
