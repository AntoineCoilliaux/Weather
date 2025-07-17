# 🌤️ Weather App

A simple and elegant iOS weather application built with SwiftUI using the MVVM design pattern. It fetches real-time weather data based on the user's current location using CoreLocation, or based on any city name entered by the user.

## Features

- Fetches current weather data from the **OpenWeatherMap API**.
- Automatically detects and displays weather for the **user’s current city** using **CoreLocation**.
- Allows users to manually search for a city and display its weather data.
- Displays:
  - City name
  - Temperature (°C)
  - Weather condition icon (based on OpenWeatherMap condition code)
- Clean and minimalist UI with a background image.

## Technologies Used

- **SwiftUI** for declarative UI.
- **Combine** via `@Published`, `@StateObject`, `@ObservableObject` to manage state.
- **CoreLocation** to access the user's current location and convert it to a city name.
- **URLSession** and `Codable` to fetch and decode weather data from OpenWeatherMap API.

## Location Services

The app requests the user's permission to access their **location while the app is in use**. If permission is granted, it automatically fetches and displays the weather for the user’s current city.

Make sure to add the required permission key to your `Info.plist`:

## Getting Started
To run the project locally:

- Clone this repository
- Open Weather.xcodeproj in Xcode
- Build and run on a simulator (or real device)

Go to openweathermap.org/api → Sign up → Get your API key, and paste it into the code where it says YOUR_API_KEY_HERE.
let url = "https://api.openweathermap.org/data/2.5/weather?q=\(cityName)&units=metric&appid=YOUR_API_KEY"
Build and run the app in the iOS Simulator or on a real device.

## Project Structure
MVVM
M: WeatherData.swift: Defines the model conforming to Codable for parsing API data.

V: ContentView.swift: Main UI with background, weather display, and text field.

VM: WeatherViewModel.swift: Handles fetching weather data and formatting for the view.

LocationManager.swift: Manages location access and reverse geocoding using CoreLocation.

