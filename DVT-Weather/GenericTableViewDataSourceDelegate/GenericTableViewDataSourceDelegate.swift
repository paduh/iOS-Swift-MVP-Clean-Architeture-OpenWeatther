//
//  GenericTableViewDataSourceDelegate.swift
//  DVT-Weather
//
//  Created by Aduh Perfect on 07/06/2021.
//

import UIKit

// MARK: - GenericTableViewDataSourceDelegate

class GenericTableViewDataSourceDelegate<Model, Cell: UITableViewCell>: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Properties
    
    typealias CellConfigurator = ((Model, Cell) -> Void)
    var models: [Model]
    private let cellConfigurator: CellConfigurator
    
    // MARK: Initializer
    
    init(models: [Model], cellConfigurator: @escaping CellConfigurator) {
        self.models = models
        self.cellConfigurator = cellConfigurator
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        let cell = tableView.dequeue(Cell.self, for: indexPath)
        cellConfigurator(model, cell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
}
