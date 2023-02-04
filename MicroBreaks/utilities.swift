//
//  utilities.swift
//  MicroBreaks
//
//  Created by LA on 30.1.2023.
//

import Foundation

func secondsToHoursMinutesSeconds(seconds: Int) -> String {
    let secondsAsInt = Int(seconds)
    return String(format: "%02i:%02i:%02i", (secondsAsInt / 3600), ((secondsAsInt % 3600) / 60), (secondsAsInt % 60))
}

func getRandomNumber(min: Double, max: Double) -> Double {
    return Double.random(in: min...max)
}

let numberFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.minimum = .init(integerLiteral: 1) // minimum of one minute
    formatter.maximum = .init(integerLiteral: 600) // maximun of 600 mins which is 10 hours
    formatter.generatesDecimalNumbers = false
    formatter.maximumFractionDigits = 0
    return formatter
}()
