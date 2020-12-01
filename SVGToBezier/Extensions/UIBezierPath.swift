//
//  UIBezierPathSVG.swift
//  SVG
//
//  Created by Bogdan Coticopol on 01.12.2020.
//

import UIKit

public extension UIBezierPath {
    
    /// Split SVG code based on the commands
    /// e.g. <path d="M324.223469,61.5025641 L203.935714,74.6423077 C206.314286,45.8769231 203.595918,30.6064103 200.877551,22.7935897"></path>
    /// - Parameter string: A string containing the path data
    /// - Returns: Array of each SVG command
    private static func svgParseCommandString(_ string: String) -> [String] {
        let pattern = "[A-Z][^A-Z]*"
        guard let results = try? string.uppercased().matches(pattern: pattern) else {
            return []
        }
        return results
    }
    
    /// Converts string of points into an array of CGPoint
    /// e.g. 206.314286,45.8769231 203.595918,30.6064103 200.877551,22.7935897 -> [CGPoint(206.314286, 45.8769231), CGPoint(203.595918,30.6064103), CGPoint(200.877551,22.7935897)]
    /// - Parameter string: string containing points
    /// - Returns: array of points
    private static func svgListOfPointsFromString(_ string: String) -> [CGPoint] {
//        print("points string: \(string)")
        return string.split(separator: " ").map {
            if let point = CGPoint.pointFromString(String($0)) {
//                print("Found point: \(point)")
                return point
            } else {
                fatalError("Invalid point format")
            }
        }
    }
    
    /// Preformat SVG commands and returns a tuple consisting of type of command and points
    /// e.g. ("L", [(194.761, 10.364)])
    /// - Parameter string: SVG command
    /// - Returns: tuple of (type of command, array of points)
    private static func svgTupleEncodedCommand(_ svgCommand: String) -> (String, [CGPoint]) {
        
        //remove white spaces
        let svgString = svgCommand.trim()
        
        //first char represents the SVG command, e.g. M
        let command = String(svgString.substr(start: 0, length: 1))
        
        //the rest of command are the points
        let parameterString = svgString.substr(start: 1, length: svgString.count - 1)
        let points = UIBezierPath.svgListOfPointsFromString(String(parameterString))
        
        return (command, points)
    }
    
    /// Main function used to generate the UIBezierPath from a SVG data string
    /// It calls previous methods in order to generate the final UIBezierPath.
    static func generateBezierFromSVG(string: String) -> UIBezierPath {
        let commands = UIBezierPath.svgParseCommandString(string)
        let instructions = commands.map {
            UIBezierPath.svgTupleEncodedCommand($0)
        }
        
        let bezierPath = UIBezierPath()
        
        print("Starting to generate UIBezierPath. If error please check the last printed instruction.")
        for instruction in instructions {
            let command = instruction.0
            let points = instruction.1
            
            print("Instruction is: \(instruction)")
            switch command {
                case "M":
                    bezierPath.move(to: points[0])
                case "C":
                    bezierPath.addCurve(to: points[2], controlPoint1: points[0], controlPoint2: points[1])
                case "L":
                    bezierPath.addLine(to: points[0])
                case "Z":
                    bezierPath.close()
                default:
                    fatalError("Invalid command encountered: \(command)")
            }
        }
        
        return bezierPath
    }
    
    /// Translate a bezier path to center it in a rect, for instance inside a CAShapeLayer
    func center(inRect rect:CGRect) {
        let rectCenter = rect.center
        let bezierCenter = self.bounds.center
        
        let translation = CGAffineTransform(translationX: rectCenter.x - bezierCenter.x, y: rectCenter.y - bezierCenter.y)
        self.apply(translation)
    }
    
}
