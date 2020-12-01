//
//  CGPoint.swift
//  WaterApp
//
//  Created by Bogdan Coticopol on 01.12.2020.
//

import CoreGraphics

public extension CGPoint {
    
    /// converts a string from format 1.23, 3 into a CGPoint (x: 1.23, y: 3)
    static func pointFromString(_ string: String) -> CGPoint? {
        
        let stringPoints = string.split(separator: ",")
        guard let x = Double(stringPoints[0])?.roundToPlaces(places: 3), let y = Double(stringPoints[1])?.roundToPlaces(places: 3) else {
            return nil
        }
        return CGPoint(x: x, y: y)
    }
}
