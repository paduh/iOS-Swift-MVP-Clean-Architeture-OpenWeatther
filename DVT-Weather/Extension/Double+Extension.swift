//
//  Double+Extension.swift
//  DVT-Weather
//
//  Created by Aduh Perfect on 08/06/2021.
//

import Foundation

extension Double {
    
    var string: String {
        String(self)
    }
    
    var celciusTemp: String {
        String(format: "%.0f", self - 273.15)
    }
}
