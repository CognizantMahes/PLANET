//
//  ViewController.swift
//  PlanetSample
//
//  Created by C, Maheswaran (Cognizant) on 20/06/21.
//

import UIKit
import CoreData

class ViewController: UIViewController {
let dataHandler = DataHandler.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchPlanetDetails()
        getPlanetDetails()
    }

    func getPlanetDetails(){
        let resultData = DataHandler.shared.fetch(Planet.self)
            //print(results.map {$0.name})
       // print(resultData.map{$0.name})
        for result in resultData ?? []{
            print(result.name)
        }
        
    }
    func fetchPlanetDetails(){
        ServiceHandler.shared.fetchJSON(){(res)in
            switch res{
            case .success(let planetData):
                planetData?.results!.forEach({result in
                    
                    guard let planet = DataHandler.shared.add(Planet.self) else {return}
                    guard let name = result.name, let url = result.url, let population = result.population else {return}
                    planet.name = name
                    planet.url = url
                    planet.population = population
                    DataHandler.shared.save()
                    
                })
            case .failure(let error):
                print("Failed to get the data", error)
                
                
            }
        }
    }

}

