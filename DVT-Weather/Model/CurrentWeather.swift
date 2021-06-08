//
//  CurrentWeather.swift
//  DVT-Weather
//
//  Created by Aduh Perfect on 08/06/2021.
//

import Foundation

// MARK: - CurrentWeather
public struct CurrentWeather: Codable {
    public let coord: Coord?
    public let weather: [Weather]?
    public let base: String?
    public let main: Main?
    public let visibility: Int?
    public let wind: Wind?
    public let clouds: Clouds?
    public let dt: Int?
    public let sys: Sys?
    public let timezone: Int?
    public let id: Int?
    public let name: String?
    public let cod: Int?

    public init(
        coord: Coord?,
        weather: [Weather]?,
        base: String?,
        main: Main?,
        visibility: Int?,
        wind: Wind?,
        clouds: Clouds?,
        dt: Int?,
        sys: Sys?,
        timezone: Int?,
        id: Int?,
        name: String?,
        cod: Int?
    ) {
        self.coord = coord
        self.weather = weather
        self.base = base
        self.main = main
        self.visibility = visibility
        self.wind = wind
        self.clouds = clouds
        self.dt = dt
        self.sys = sys
        self.timezone = timezone
        self.id = id
        self.name = name
        self.cod = cod
    }
}

// MARK: - Clouds
public struct Clouds: Codable {
    public let all: Int?

    public init(all: Int?) {
        self.all = all
    }
}

// MARK: - Coord
public struct Coord: Codable {
    public let lon: Double?
    public let lat: Double?

    public init(lon: Double?, lat: Double?) {
        self.lon = lon
        self.lat = lat
    }
}

// MARK: - Sys
public struct Sys: Codable {
    public let type: Int?
    public let id: Int?
    public let message: Double?
    public let country: String?
    public let sunrise: Int?
    public let sunset: Int?

    public init(
        type: Int?,
        id: Int?,
        message: Double?,
        country: String?,
        sunrise: Int?,
        sunset: Int?
    ) {
        self.type = type
        self.id = id
        self.message = message
        self.country = country
        self.sunrise = sunrise
        self.sunset = sunset
    }
}

// MARK: - Weather
public struct Weather: Codable {
    public let id: Int?
    public let main: String?
    public let description: String?
    public let icon: String?

    public init(
        id: Int?,
        main: String?,
        description: String?,
        icon: String?
    ) {
        self.id = id
        self.main = main
        self.description = description
        self.icon = icon
    }
}
