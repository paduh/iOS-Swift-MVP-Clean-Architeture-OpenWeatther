//
//  WeatherPresenter.swift
//  DVT-Weather
//
//  Created by Aduh Perfect on 08/06/2021.
//

import Foundation

// MARK: - WeatherPresenterView

final class WeatherPresenter {
    
    // MARK: Properties

    private let currentWeatherService: WeatherService<CurrentWeather>!
    private let fiveDaysWeatherService: WeatherService<FiveDaysWeather>!
    private var dispatchGroup: DispatchGroup!
    weak var weatherView: WeatherView?
    var currentWeather: CurrentWeather? {
        didSet {
            let weatherInfo = WeatherInfo(
                backgroundImageName: backgroundImageName,
                temperature: temperature,
                minTemperature: minTemperature,
                maxTemperature: maxTemperature
            )
            self.weatherInfoCompletion?(weatherInfo)
        }
    }
    var weatherInfoCompletion: ((WeatherInfo) -> Void)?
    var weatherType: String = ""
    
    // MARK: - Initializer / DeInitializer
    
    init(
        currentWeatherService: WeatherService<CurrentWeather> = WeatherService<CurrentWeather>(),
        fiveDaysWeatherService: WeatherService<FiveDaysWeather> = WeatherService<FiveDaysWeather>()
    ) {
        self.currentWeatherService = currentWeatherService
        self.fiveDaysWeatherService = fiveDaysWeatherService
    }
    
    func viewDidLoad() {
        dispatchGroup = DispatchGroup()
        weatherView?.showLoadingStatus()
        dispatchGroup.notify(queue: .main) { [ weak self] in
            guard let self = self else { return }
            self.weatherView?.hideLoadingStatus()
        }
    }
    
    func attachView(view: WeatherView) {
        weatherView = view
    }
    
    func detachView() {
        weatherView = nil
    }
}

// MARK: - Helpers

extension WeatherPresenter {
    
    var minTemperature: String {
        guard let temp = currentWeather?.main?.tempMin?.celciusTemp else { return "" }
        return temp + "\n\(R.string.text.min())"
    }
    
    var maxTemperature: String {
        guard let temp = currentWeather?.main?.tempMax?.celciusTemp else { return "" }
        return temp + "\n\(R.string.text.max())"
    }
    
    var temperature: String {
        guard let temp = currentWeather?.main?.temp?.celciusTemp else { return "" }
        return  temp + "\n\(weatherType)"
    }
    
    var backgroundImageName: String {
        guard let main = currentWeather?.weather?.first?.main else { return "" }
        guard let weatherType = WeatherType(rawValue: main) else { return "" }
        self.weatherType = weatherType.title
        switch weatherType {
        case .clear: return R.image.sea_sunnypng.name
        case .clouds: return R.image.sea_cloudy.name
        case .rain: return R.image.sea_rainy.name
        }
    }
}

// MARK: - API

extension WeatherPresenter {
    
    // MARK: - Current Weather
    
    func fetchCurrentWeather(lat: Double, long: Double) {
        dispatchGroup.enter()
        currentWeatherService.currentWeather(lat: lat, long: long) { [ weak self] (result) in
            guard let self = self else { return }
            self.dispatchGroup.leave()
            switch result {
            case .failure(let error):
                self.weatherView?.showErrorWith(message: error.title)
            case .success(let currentWeather):
                guard let currentWeather = currentWeather else {
                    self.weatherView?.showEmptyState()
                    return
                }
                
                self.currentWeather = currentWeather
                self.weatherView?.show(currentWeather: currentWeather)
            }
        }
    }
    
    // MARK: - Five Days Weather Forcast
    
    func fetchFiveDaysWeather(lat: Double, long: Double) {
        dispatchGroup.enter()
        fiveDaysWeatherService.fiveDayWeatherForcast(lat: lat, long: long) { [ weak self] (result) in
            guard let self = self else { return }
            self.dispatchGroup.leave()
            switch result {
            case .failure(let error):
                self.weatherView?.showErrorWith(message: error.title)
            case .success(let fiveDayWeatherForcast):
                guard let fiveDayWeatherForcast = fiveDayWeatherForcast else {
                    self.weatherView?.showEmptyState()
                    return
                }
                self.weatherView?.show(fiveDaysWeather: fiveDayWeatherForcast)
            }
        }
    }
}
