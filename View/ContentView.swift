//
//  ContentView.swift
//  Weather
//
//  Created by Antoine Coilliaux on 10/07/2025.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    @StateObject var locationManager = LocationManager()
    @StateObject var viewModel = WeatherViewModel()
    @State var cityName = ""
    
    var body: some View {
        
        ZStack {
            Image("background")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack (spacing: 20) {
                Spacer()
                TextField("Enter a city", text: $cityName)
                    .submitLabel(.search)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.top, 40)
                    .onSubmit {
                        Task {
                            await viewModel.fetchWeather(cityName: cityName)
                        }
                    }
                
                Text(viewModel.cityName)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding()
                
                Image(systemName: viewModel.systemImageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 190, height: 150)
                    .foregroundColor(.black)
                
                
                Text("\(viewModel.temperature, specifier: "%.1f")°C")
                    .font(.system(size: 50))
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                Spacer()
                Spacer()
                
            }
        }

        .onChange(of: locationManager.cityName) { newCity in
            Task {
                await viewModel.fetchWeather(cityName: newCity)
                viewModel.cityName = newCity
            }
        }
    }
    
}


#Preview {
    ContentView()
}
