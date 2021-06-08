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

    private let currentweatherService: WeatherService<CurrentWeather>!
    private let fiveDaysweatherService: WeatherService<FiveDaysWeather>!
    private var dispatchGroup: DispatchGroup!
    weak var weatherView: WeatherView?
    
    // MARK: - Initializer / DeInitializer
    
    init(
        currentweatherService: WeatherService<CurrentWeather> = WeatherService<CurrentWeather>(),
        fiveDaysweatherService: WeatherService<FiveDaysWeather> = WeatherService<FiveDaysWeather>()
    ) {
        self.currentweatherService = currentweatherService
        self.fiveDaysweatherService = fiveDaysweatherService
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

// MARK: - API

extension WeatherPresenter {
    
    // MARK: - Current Weather
    
    func fetchCurrentWeather() {
        dispatchGroup.enter()
        currentweatherService.currentWeather { [ weak self] (result) in
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
                self.weatherView?.show(currentWeather: currentWeather)
            }
        }
    }
    
    // MARK: - Five Days Weather Forcast
    
    func fetchFiveDaysWeather() {
        dispatchGroup.enter()
        fiveDaysweatherService.fiveDayWeatherForcast { [ weak self] (result) in
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
