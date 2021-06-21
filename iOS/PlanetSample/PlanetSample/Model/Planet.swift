//
//  Planet.swift
//  PlanetSample
//
//  Created by C, Maheswaran (Cognizant) on 20/06/21.
//

import Foundation
import CoreData

class Planet: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var population: String
    @NSManaged var url: String
    

}
