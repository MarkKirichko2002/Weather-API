//
//  Interactor.swift
//  Weather API
//
//  Created by Марк Киричко on 24.08.2022.
//

import Foundation
import Alamofire
import CoreLocation

protocol AnyInteractor {
    var presenter: AnyPresenter? {get set}
    
    func getWeather()
}

class WeatherInteractor: AnyInteractor {
    
    var presenter: AnyPresenter?
    var locationManager = CLLocationManager()
    var currentLoc: CLLocation?
    var latitude = 0.0
    var longitude = 0.0
    
    func GetLocation() {
        locationManager.requestWhenInUseAuthorization()
        currentLoc = locationManager.location
        print(currentLoc?.coordinate.latitude ?? 0.0)
        print(currentLoc?.coordinate.longitude ?? 0.0)
        latitude = currentLoc?.coordinate.latitude ?? 0.0
        longitude = currentLoc?.coordinate.longitude ?? 0.0
    }
    
    func getWeather() {
        GetLocation()
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=apikey"
        AF.request(url).responseData { response in
            guard let data = response.data else {return}
            
            var response: WeatherResponse?
            
            do {
                response = try JSONDecoder().decode(WeatherResponse.self, from: data)
                self.presenter?.interactorDidFetchWeather(with: .success(response!.weather))
            } catch {
                self.presenter?.interactorDidFetchWeather(with: .failure(error))
            }
        }
    }
}
