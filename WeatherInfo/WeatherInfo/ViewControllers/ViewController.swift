//
//  ViewController.swift
//  WeatherInfo
//
//  Created by Suhyoung Eo on 2022/01/18.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayWeather(nil)
        
        cityNameTextField.rx.controlEvent(.editingDidEndOnExit)
            .asObservable()
            .map { self.cityNameTextField.text }
            .subscribe(onNext: { city in
                
                if let city = city {
                    if city.isEmpty {
                        self.displayWeather(nil)
                    } else {
                        self.fetchWeather(at: city)
                    }
                }
            }).disposed(by: disposeBag)
       
        /*
        // 타이핑 시 실시간으로 업데이트 되므로 시스템에 부하가 많이 걸림
        cityNameTextField.rx.value
            .subscribe(onNext: { [self] city in

                if let city = city {
                    if city.isEmpty {
                        displayWeather(nil)
                    } else {
                        fetchWeather(at: city)
                        print(city)
                    }
                }
            }).disposed(by: disposeBag)
        */
        
    }
    
    private func fetchWeather(at city: String) {
        
        guard let cityEncoded = city.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let url = URL.urlForWeatherApi(city: cityEncoded) else { return }
        
        let resource = Resource<WeatherModel>(url: url)
        
        /*
        // RxSwift만 사용
        URLRequest.load(resource: resource)
            .observeOn(MainScheduler.instance)  // DispatchQueue.main.async 와 같은 역할
            .catchErrorJustReturn(WeatherModel.empty)
            .subscribe(onNext: { weatherModel in
                self.displayWeather(weatherModel)
            }).disposed(by: disposeBag)
        */
        
        /*
        let search = URLRequest.load(resource: resource)
            .observeOn(MainScheduler.instance)
            .asDriver(onErrorJustReturn: WeatherModel.empty)
        */
        
        // Error handling
        let search = URLRequest.load(resource: resource)
            .observeOn(MainScheduler.instance)
            .retry(3)
            .catchError { error in
                print("catchError", error.localizedDescription)
                return Observable.just(WeatherModel.empty)
            }.asDriver(onErrorJustReturn: WeatherModel.empty)
        
        
        // RxCocoa를 이용한 binding
        search.map { $0.name }
        .drive(self.cityNameLabel.rx.text)
        .disposed(by: disposeBag)
        
        search.map { "\($0.main.temp) ℃" }
        .drive(self.temperatureLabel.rx.text)
        .disposed(by: disposeBag)
        
        search.map { "\($0.main.humidity) 💦" }
        .drive(self.humidityLabel.rx.text)
        .disposed(by: disposeBag)
        
        search.map { $0.weather[0].description }
        .drive(self.descriptionLabel.rx.text)
        .disposed(by: disposeBag)
        
    }
    
    private func displayWeather(_ weatherModel: WeatherModel?) {
        
        if let weatherModel = weatherModel {
            cityNameLabel.text =  weatherModel.name
            temperatureLabel.text = "\(weatherModel.main.temp) ℃"
            humidityLabel.text = "\(weatherModel.main.humidity) 💦"
            descriptionLabel.text = weatherModel.weather[0].description
        } else {
            cityNameLabel.text = "⌀"
            temperatureLabel.text = "🙈"
            humidityLabel.text = "⌀"
            descriptionLabel.text = ""
        }
    }

}
