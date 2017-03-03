//
//  WeatherData.swift
//  NetworkingExample
//
//  Created by Rasko Gojkovic on 3/2/17.
//  Copyright © 2017 Plantronics. All rights reserved.
//

import Foundation

class WeatherConstants{
    
    static func UrlForIcon(icon: String) -> (String){
        return iconUrlBase + icon + ".png"
    }
    static let APIKey = "8a0e48bd16452efb2f5b9ba29a927163"
    static let iconUrlBase = "http://openweathermap.org/img/w/"
}
