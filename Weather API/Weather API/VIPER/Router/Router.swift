//
//  Router.swift
//  Weather API
//
//  Created by Марк Киричко on 24.08.2022.
//

import UIKit

typealias EntryPoint = AnyView & UIViewController

protocol AnyRouter {
    var entry: EntryPoint? { get }
    
    static func start()-> AnyRouter
}

class WeatherRouter: AnyRouter {
    
    var entry: EntryPoint?
    
    static func start()-> AnyRouter {
        let router = WeatherRouter()
        
        // Assign VIP
        var view: AnyView = WeatherViewController()
        var presenter: AnyPresenter = WeatherPresenter()
        var interactor: AnyInteractor = WeatherInteractor()
        
        view.presenter = presenter
        
        interactor.presenter = presenter
        
        presenter.router = router
        presenter.view = view
        presenter.interactor = interactor
        
        router.entry = view as? EntryPoint
        
        return router
    }

}
