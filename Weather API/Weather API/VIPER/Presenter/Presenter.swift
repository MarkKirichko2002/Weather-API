//
//  Presenter.swift
//  Weather API
//
//  Created by Марк Киричко on 24.08.2022.
//

import Foundation

enum FetchError {
    case failed
}

protocol AnyPresenter {
    var router: AnyRouter? {get set}
    var interactor: AnyInteractor? {get set}
    var view: AnyView? {get set}
    
    func interactorDidFetchWeather(with result: Result<[Weather], Error>)
}

class WeatherPresenter: AnyPresenter {
    var router: AnyRouter?
    
    var interactor: AnyInteractor? {
        didSet {
            interactor?.getWeather()
        }
    }
    
    var view: AnyView?
    
    func interactorDidFetchWeather(with result: Result<[Weather], Error>) {
        switch result {
        case .success(let weather):
            view?.update(with: weather)
            
        case .failure:
            view?.update(with: "error")
        }
    }
    
}
