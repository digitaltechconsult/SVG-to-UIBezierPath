//
//  CGRect.swift
//  WaterApp
//
//  Created by Bogdan Coticopol on 01.12.2020.
//

import CoreGraphics

public extension CGRect {
    var center: CGPoint { return CGPoint(x: midX, y: midY) }
}
