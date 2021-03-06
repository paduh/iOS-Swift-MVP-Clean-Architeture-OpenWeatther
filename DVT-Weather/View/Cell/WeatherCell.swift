//
//  WeatherCell.swift
//  DVT-Weather
//
//  Created by Aduh Perfect on 08/06/2021.
//

import UIKit

// MARK: - WeatherCellPreentable

protocol WeatherCellPreentable {
    func configureCell(item: WeatherItem)
}

// MARK: - WeatherCell

final class WeatherCell: UITableViewCell {
    
    // MARK: - IBOutlets

    @IBOutlet weak private var forcastDateLabel: UILabel!
    @IBOutlet weak private var temperatureLabel: UILabel!
    @IBOutlet weak private var weatherIconImageView: UIImageView!
    
    // MARK: - Life Cycle Methods


    override func awakeFromNib() {
        super.awakeFromNib()

    }
}

// MARK: - WeatherCellPreentable

extension WeatherCell: WeatherCellPreentable {
    func configureCell(item: WeatherItem) {
        forcastDateLabel.text = item.forcastDate
        temperatureLabel.text = item.temperature
        weatherIconImageView.image = item.weatherImage
    }
}
