//
//  DecimalToFraction.swift
//  FlavorShare_iOS
//
//  Created by Benjamin Lefebvre on 2025-01-07.
//

import Foundation

func gcd(_ a: Int, _ b: Int) -> Int {
    if b == 0 {
        return a
    }
    return gcd(b, a % b)
}

func decimalToFraction(_ decimal: Double, precision: Int = 6) -> String {
    if decimal == 0 {
        return "0"
    }

    let roundedDecimal = round(decimal * pow(10.0, Double(precision))) / pow(10.0, Double(precision))
    let wholePart = Int(roundedDecimal)
    let fractionalPart = roundedDecimal - Double(wholePart)

    if fractionalPart == 0 {
        return "\(wholePart)"
    }

    let len = String(fractionalPart).count - 2
    let denominator = Int(pow(10.0, Double(len)))
    let numerator = Int(fractionalPart * Double(denominator))

    let divisor = gcd(numerator, denominator)

    let num = numerator / divisor
    let den = denominator / divisor

    if wholePart == 0 {
        return "\(num)/\(den)"
    } else {
        return "\(wholePart) \(num)/\(den)"
    }
}

// Example usage:
//print(decimalToFraction(0.17)) // Output: "1/6"
