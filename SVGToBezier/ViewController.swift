//
//  ViewController.swift
//  SVGToBezier
//
//  Created by Bogdan Coticopol on 01.12.2020.
//

import UIKit

class ViewController: UIViewController {
    
    func shapeLayerFromSVG(rect: CGRect) -> CAShapeLayer {
        let bezier = UIBezierPath.generateBezierFromSVG(string: SVGData.data)
        
        let shape = CAShapeLayer()
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        shape.bounds = rect
        shape.position = rect.center
        
        bezier.center(inRect: rect)
        shape.path = bezier.cgPath
        
        return shape
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let shape = shapeLayerFromSVG(rect: view.frame)
        view.layer.addSublayer(shape)
    }


}

