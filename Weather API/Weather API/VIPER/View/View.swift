//
//  View.swift
//  Weather API
//
//  Created by Марк Киричко on 24.08.2022.
//

import UIKit

protocol AnyView {
    var presenter: AnyPresenter? {get set}
    
    func update(with weather: [Weather])
    func update(with error: String)
}

class WeatherViewController: UIViewController, AnyView{
    
    var presenter: AnyPresenter?

    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    var weather: [Weather] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        view.backgroundColor = .white
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        label.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        label.center = view.center
    }
    
    func update(with weather: [Weather]) {
        print("got weather")
        DispatchQueue.main.async {
            self.weather = weather
            print(self.weather)
            self.label.text = "\(weather[0].weatherDescription)"
        }
    }
    
    func update(with error: String) {
        print(error)
        DispatchQueue.main.async {
            self.weather = []
            self.label.text = error
        }
    }
    
}
