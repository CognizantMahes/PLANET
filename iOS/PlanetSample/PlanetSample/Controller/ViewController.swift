//
//  ViewController.swift
//  PlanetSample
//
//  Created by C, Maheswaran (Cognizant) on 20/06/21.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    // Planet Table View
    @IBOutlet weak var planetTableView: UITableView!
    //Data handler to store and fetch from Core data
    let dataHandler = DataHandler.shared
    //View model class instance
    var planetViewModel = [PlanetViewModel]()
    //Activity indeicator
    var activityIndicator = UIActivityIndicatorView(style: .medium )

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //Navigation titles
        self.title = HomeTitle
        //Activity indicator setup method
        setupActivityIndicator()
    
        // Initiate API Call
        fetchPlanetDetails()
        
    }
    //setup thr Activity indicator with style and loction
    func setupActivityIndicator (){
        view.bringSubviewToFront(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(activityIndicator)
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    //display Activity
    func showActivity(){
        activityIndicator.startAnimating()
    }
    //Hide Activity
    func hideActivity(){
        //UI update in main
        DispatchQueue.main.async{
            self.activityIndicator.stopAnimating()
        }
    }
    
    //Read from core Data and create a view model
    func getPlanetDetails(){
        //call fetch entity operation
        let resultData = DataHandler.shared.fetch(Planet.self)! as [Planet]
        // from the result create view model
        planetViewModel = resultData.map({return PlanetViewModel(planet: $0)})
        //print(planetViewModel)
        //Main thread Table update
        DispatchQueue.main.async{
            self.planetTableView.reloadData()
        }
       
        
    }
    //API call
    func fetchPlanetDetails(){
        showActivity()
        
        ServiceHandler.shared.fetchJSON(){(result)in
            switch result{
            case .success(let planetData):
                //success
                //Delete previous entries
                DataHandler.shared.deleteAllData("Planet")
                //Parse the data and store in core data
                planetData?.results!.forEach({result in
                    guard let planet = DataHandler.shared.add(Planet.self) else {return}
                    guard let name = result.name, let url = result.url, let population = result.population else {return}
                    planet.name = name
                    planet.url = url
                    planet.population = population
                    DataHandler.shared.save()
                })
                //get all model object
                self.getPlanetDetails()
                
                self.hideActivity()
            case .failure(let error):
                print("Failed to get the data", error)
                // get the model object
                self.getPlanetDetails()
                self.hideActivity()
                
            }
        }
    }

}
//table view datasource
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
