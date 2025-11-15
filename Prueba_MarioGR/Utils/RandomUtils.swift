//
//  RandomUtils.swift
//  Prueba_MarioGR
//
//  Created by MarioGutierrez on 11/13/25.
//

import Foundation
import CoreLocation

struct SeededRandomNumberGenerator: RandomNumberGenerator {
    private var state: UInt64

    init(seed: UInt64) {
        self.state = seed == 0 ? 0x4d595df4d0f33173 : seed
    }

    mutating func next() -> UInt64 {
        let a: UInt64 = 6364136223846793005
        let c: UInt64 = 1
        state = a &* state &+ c
        return state
    }
}

func randomCoordinate(for id: Int) -> CLLocationCoordinate2D {
    var generator = SeededRandomNumberGenerator(seed: UInt64(id))
    let latitude = Double.random(in: -90...90, using: &generator)
    let longitude = Double.random(in: -180...180, using: &generator)
    return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
}

import CoreLocation

struct MapPin: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}
