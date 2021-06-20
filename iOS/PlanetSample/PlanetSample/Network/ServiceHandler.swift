//
//  ServiceHandler.swift
//  PlanetSample
//
//  Created by C, Maheswaran (Cognizant) on 20/06/21.
//

import Foundation
class ServiceHandler{

    static let shared = ServiceHandler()
    private init(){}
    
    func fetchJSON(completion: @escaping(Result<PlanetData?,Error>) -> ()){
    let apiURLString =  "https://swapi.dev/api/planets/"
    guard let apiURL = URL(string: apiURLString) else {
        return
    }
    URLSession.shared.dataTask(with: apiURL) { data,response, error in
        if let error = error{
            completion(.failure(error))
            return
        }
        //success
        do {
            let welcomeObj = try JSONDecoder().decode(PlanetData.self, from: data!)
            completion(.success(welcomeObj))
        }catch {
            completion(.failure(error))
       }
    }.resume()
}
    
}
