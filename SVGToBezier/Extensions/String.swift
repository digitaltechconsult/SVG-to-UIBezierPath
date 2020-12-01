//
//  String.swift
//  WaterApp
//
//  Created by Bogdan Coticopol on 01.12.2020.
//

import Foundation

public extension String {
    func matches(pattern: String) throws -> [String] {
        let regex = try NSRegularExpression(pattern: pattern)
        let results = regex.matches(in: self, options: [], range: NSRange(self.startIndex..., in: self))
        return results.compactMap({ result in
            if let range = Range(result.range, in: self) {
                return String(self[range])
            } else {
                return nil
            }
        })
    }

    func hasPattern(pattern: String) throws -> Bool {
        return try !matches(pattern: pattern).isEmpty
    }
    
    func substr(start: Int, length: Int) -> Substring {
        let startIndex = self.index(self.startIndex, offsetBy: start)
        let stopIndex = self.index(self.startIndex, offsetBy: start + (length > self.count - start ? self.count - start : length))
        return self[startIndex..<stopIndex]
    }
    
    func trim() -> String {
        return self.trimmingCharacters(in: .whitespaces)
    }
}
