//
//  VolumeToPercentageFormatter.swift
//  AKVolumeControl
//
//  Created by Mark Jeschke on 3/14/23.
//

import Foundation

class Formatter {
    func floatToPercentage(with volume: Float ) -> String {
        String(format: "%.0f", volume * 100)
    }
}
