//
//  PlanetSampleTests.swift
//  PlanetSampleTests
//
//  Created by C, Maheswaran (Cognizant) on 20/06/21.
//

import XCTest
@testable import PlanetSample
import CoreData

class PlanetSampleTests: XCTestCase {
    let viewContext = (UIApplication.shared.delegate as!  AppDelegate).persistentContainer.viewContext
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testPlanetViewModel(){
        let entityName = "Planet"
        let entity = NSEntityDescription.entity(forEntityName: entityName, in: viewContext)
        let planet = Planet(entity: entity! , insertInto:viewContext )
        planet.name = "TEST NAME"
        planet.url = ""
        planet.population = ""
       
        
        let planetViewModel = PlanetViewModel(planet: planet)
        XCTAssertEqual(planetViewModel.name, planet.name)
    }
    
    
      

}
