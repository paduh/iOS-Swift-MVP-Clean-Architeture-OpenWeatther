//
//  FiveDaysWeather.swift
//  DVT-Weather
//
//  Created by Aduh Perfect on 08/06/2021.
//

import Foundation

// MARK: - FiveDaysWeather
public struct FiveDaysWeather: Codable {
    public let cod: String?
    public let message: Int?
    public let cnt: Int?
    public let list: [List]?
    public let city: City?

    public init(
        cod: String?,
        message: Int?,
        cnt: Int?,
        list: [List]?,
        city: City?
    ) {
        self.cod = cod
        self.message = message
        self.cnt = cnt
        self.list = list
        self.city = city
    }
}

// MARK: - City
public struct City: Codable {
    public let id: Int?
    public let name: String?
    public let coord: Coord?
    public let country: String?
    public let timezone: Int?
    public let sunrise: Int?
    public let sunset: Int?

    public init(
        id: Int?,
        name: String?,
        coord: Coord?,
        country: String?,
        timezone: Int?,
        sunrise: Int?,
        sunset: Int?
    ) {
        self.id = id
        self.name = name
        self.coord = coord
        self.country = country
        self.timezone = timezone
        self.sunrise = sunrise
        self.sunset = sunset
    }
}

// MARK: - List
public struct List: Codable {
    public let dt: Int?
    public let main: Main?
    public let weather: [Weather]?
    public let clouds: Clouds?
    public let wind: Wind?
    public let visibility: Int?
    public let pop: Double?
    public let rain: Rain?
    public let sys: Sys?
    public let dtTxt: String?

    enum CodingKeys: String, CodingKey {
        case dt = "dt"
        case main = "main"
        case weather = "weather"
        case clouds = "clouds"
        case wind = "wind"
        case visibility = "visibility"
        case pop = "pop"
        case rain = "rain"
        case sys = "sys"
        case dtTxt = "dt_txt"
    }

    public init(
        dt: Int?,
        main: Main?,
        weather: [Weather]?,
        clouds: Clouds?,
        wind: Wind?,
        visibility: Int?,
        pop: Double?,
        rain: Rain?,
        sys: Sys?,
        dtTxt: String?
    ) {
        self.dt = dt
        self.main = main
        self.weather = weather
        self.clouds = clouds
        self.wind = wind
        self.visibility = visibility
        self.pop = pop
        self.rain = rain
        self.sys = sys
        self.dtTxt = dtTxt
    }
}

// MARK: - Main
public struct Main: Codable {
    public let temp: Double?
    public let feelsLike: Double?
    public let tempMin: Double?
    public let tempMax: Double?
    public let pressure: Int?
    public let seaLevel: Int?
    public let grndLevel: Int?
    public let humidity: Int?
    public let tempKf: Double?

    enum CodingKeys: String, CodingKey {
        case temp = "temp"
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure = "pressure"
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity = "humidity"
        case tempKf = "temp_kf"
    }

    public init(
        temp: Double?,
        feelsLike: Double?,
        tempMin: Double?,
        tempMax: Double?,
        pressure: Int?,
        seaLevel: Int?,
        grndLevel: Int?,
        humidity: Int?,
        tempKf: Double?
    ) {
        self.temp = temp
        self.feelsLike = feelsLike
        self.tempMin = tempMin
        self.tempMax = tempMax
        self.pressure = pressure
        self.seaLevel = seaLevel
        self.grndLevel = grndLevel
        self.humidity = humidity
        self.tempKf = tempKf
    }
}

// MARK: - Rain
public struct Rain: Codable {
    public let the3H: Double?

    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }

    public init(the3H: Double?) {
        self.the3H = the3H
    }
}

// MARK: - Wind
public struct Wind: Codable {
    public let speed: Double?
    public let deg: Int?
    public let gust: Double?

    public init(
        speed: Double?,
        deg: Int?,
        gust: Double?
    ) {
        self.speed = speed
        self.deg = deg
        self.gust = gust
    }
}

public enum WeatherType: String, Codable {
    case rain = "Rain"
    case clear = "Clear"
    case clouds = "Clouds"
    
    var title: String {
        switch self {
        case .clear: return R.string.text.clear()
        case .rain: return R.string.text.rain()
        case .clouds: return R.string.text.clouds()
        }
    }
}


// Rain, Clear, Clouds
