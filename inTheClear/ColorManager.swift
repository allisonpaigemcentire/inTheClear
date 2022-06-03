//
//  ColorManager.swift
//  inTheClear
//
//  Created by Allison Mcentire on 6/2/22.
//

import Foundation
import UIKit

class ColorManager {
 
    let blue = UIColor(named: "Bdazzled Blue")?.cgColor
    let pink = UIColor(named: "Red Salsa")?.cgColor
    let lightPink = UIColor(named: "Light Pink")?.cgColor
    let blanchedAlmond = UIColor(named: "Blanched Almond")?.cgColor
    let aero = UIColor(named: "Aero")?.cgColor
    let defaultBlue = UIColor(named: "Bdazzled Blue")
    
    func getArrayOfColors(number: Int) -> [CGColor] {
        let blueArray: [CGColor?] = Array(repeating: blue, count: number)
        let pinkArray: [CGColor?] = Array(repeating: pink, count: number)
        let aeroArray: [CGColor?] = Array(repeating: aero, count: number)
        let lightPinkArray: [CGColor?] = Array(repeating: lightPink, count: number)
        let fullArray = (blueArray + pinkArray + aeroArray + lightPinkArray).shuffled()

        var colorArray = [CGColor]()
        for item in 0...number {
            if let color = fullArray[item] {
                colorArray.append(color)
            }
        }
        return colorArray
    }
    
}
