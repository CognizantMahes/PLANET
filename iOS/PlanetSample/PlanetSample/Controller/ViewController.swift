//
//  ViewController.swift
//  PlanetSample
//
//  Created by C, Maheswaran (Cognizant) on 20/06/21.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var planetTableView: UITableView!
    
    let dataHandler = DataHandler.shared
    
    var planetViewModel = [PlanetViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Planets"
        
        fetchPlanetDetails()
        
    }

    func getPlanetDetails(){
        let resultData = DataHandler.shared.fetch(Planet.self)! as [Planet]
            //print(results.map {$0.name})
        //print(resultData.map{$0.name})
        planetViewModel = resultData.map({return PlanetViewModel(planet: $0)})
        //planetViewModel.map[{return }]
        for result in resultData {
            //print(result.name)
        }
       print(planetViewModel)
        DispatchQueue.main.async{
            self.planetTableView.reloadData()
        }
       
        
    }
    func fetchPlanetDetails(){
        ServiceHandler.shared.fetchJSON(){(res)in
            switch res{
            case .success(let planetData):
                DataHandler.shared.deleteAllData("Planet")
                self.getPlanetDetails()
                
                planetData?.results!.forEach({result in
                    
                    guard let planet = DataHandler.shared.add(Planet.self) else {return}
                    guard let name = result.name, let url = result.url, let population = result.population else {return}
                    planet.name = name
                    planet.url = url
                    planet.population = population
                   
                    DataHandler.shared.save()
                   
                    
                })
                self.getPlanetDetails()
            case .failure(let error):
                print("Failed to get the data", error)
                
                
            }
        }
    }

}

extension ViewController: UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return planetViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlanetCell") as! PlanetCell
        cell.planet = planetViewModel[indexPath.row]
        return cell
    }
    
    
}
