//
//  Double.swift
//  WaterApp
//
//  Created by Bogdan Coticopol on 01.12.2020.
//

import Foundation

public extension Double {
    /// Rounds the double to decimal places value
    func roundToPlaces(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
