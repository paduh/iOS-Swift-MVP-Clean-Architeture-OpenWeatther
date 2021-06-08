//
//  WeatherController.swift
//  DVT-Weather
//
//  Created by Aduh Perfect on 08/06/2021.
//

import UIKit

// MARK:- WeatherController

class WeatherController: UIViewController {

    // MARK:- IBOutlets
    
    @IBOutlet weak var currentTempValueLabel: UILabel!
    @IBOutlet weak var minTempValueLabel: UILabel!
    @IBOutlet weak var maxTempValueLabel: UILabel!
    @IBOutlet weak var tempValueLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak private var tableView: UITableView! {
        didSet {
            tableView.register(WeatherCell.self)
        }
    }
    
    // MARK: Properties
    var presenter: WeatherPresenter! = WeatherPresenter()
    var dataSourceDelegate: GenericTableViewDataSourceDelegate<List, WeatherCell>! {
        didSet {
            
        }
    }
    
    // MARK: Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        handlePresenter()
    }
    
    deinit {
        presenter.detachView()
    }

    func setupTableView() {
        tableView.dataSource = dataSourceDelegate
        tableView.delegate = dataSourceDelegate
    }
    
    func handlePresenter() {
        presenter.viewDidLoad()
        presenter.fetchCurrentWeather(lat: 51.5073, long: -0.1277) // TODO Implement Core location and pass the users current location
        presenter.fetchFiveDaysWeather(lat: 51.5073, long: -0.1277) // TODO Implement Core location and pass the users current location
        presenter.attachView(view: self)
        
        presenter.weatherInfoCompletion = { [weak self] info in
            guard let self = self else { return }
            self.backgroundImageView.image = UIImage(named: info.backgroundImageName)
            self.tempValueLabel.text = info.temperature
            self.minTempValueLabel.text = info.minTemperature
            self.maxTempValueLabel.text = info.maxTemperature
            self.currentTempValueLabel.text =  info.temperature
        }
    }
}

// MARK:- WeatherView

extension WeatherController: WeatherView {
    func showLoadingStatus() {
        // TODO Implement Loading view here
    }
    
    func hideLoadingStatus() {
        // TODO Implement hide Loading view here
    }
    
    func show(title aTitle: String) {
        
    }
    
    func show(currentWeather: CurrentWeather) {
        
    }
    
    func showErrorWith(message: String) {
        
    }
    
    func show(fiveDaysWeather: FiveDaysWeather) {
        guard let weatherList = fiveDaysWeather.list else { return }
        dataSourceDelegate = GenericTableViewDataSourceDelegate<List, WeatherCell>(models: weatherList, cellConfigurator: { (model, cell) in
            let item = WeatherItem(model: model)
            cell.configureCell(item: item)
        })
        tableView.dataSource = dataSourceDelegate
        tableView.reloadData()
    }
    
    func showEmptyState() {
        
    }
}
