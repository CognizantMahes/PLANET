//
//  PlanetViewModel.swift
//  PlanetSample
//
//  Created by C, Maheswaran (Cognizant) on 20/06/21.
//

import Foundation

struct PlanetViewModel{
    var name: String
    init(planet: Planet){
        self.name = planet.name
    }
}
