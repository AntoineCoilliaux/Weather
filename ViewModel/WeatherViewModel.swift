//
//  WeatherViewModel.swift
//  Weather
//
//  Created by Antoine Coilliaux on 10/07/2025.
//

import Foundation
@MainActor
class WeatherViewModel: ObservableObject {
    
    
    
    @Published var cityName: String = ""
    @Published var temperature: Double = 0.0
    @Published var id: Int = 0
    var systemImageName: String {
        switch id {
        case 200...232:
            return "cloud.bolt.rain"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 701...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud"
        default:
            return "questionmark"
        }
    }
    func fetchWeather (cityName: String) async {
        guard
                let path = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
                let dict = NSDictionary(contentsOfFile: path),
                let apiKey = dict["OPENWEATHER_API_KEY"] as? String
            else {
                print("❌ API key did not load")
                return
            }


        let url = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&units=metric&appid=\(apiKey)"
        
            guard let url = URL(string: url) else { return }
            
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let decodedData = try JSONDecoder().decode(WeatherData.self, from: data)
                    self.temperature = decodedData.main.temp
                    self.id = decodedData.weather[0].id
                self.cityName = decodedData.name
            } catch {
                print(error)
            }
        }
    }
