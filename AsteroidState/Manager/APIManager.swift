//
//  APIManager.swift
//  AsteroidState
//
//  Created by Sanjay Thakkar on 07/02/23.
//

import Foundation

let APIManager = APIManagerClass.shared

class APIManagerClass {
    static var shared = APIManagerClass()
    
    func getAstroids(withRange
                     from:Date,
                     to:Date,
                     completion: @escaping ([AstroidObject]?)->()
    ) {
        
        let apiKey = "7a9BlkA6LrJXLrEngGkkyOvodhf3alh1QQ8KGx61"
        let urlString = "https://api.nasa.gov/neo/rest/v1/feed?start_date=\(from.toValidFormat())&end_date=\(to.toValidFormat())&api_key=\(apiKey)"
            
            guard let url = URL(string: urlString) else {
                completion(nil)
                return
            }
            
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    completion(nil)
                    return
                }
                
                guard let data = data else {
                    completion(nil)
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let neoFeed = try decoder.decode(AstroidsResponse.self, from: data)
                    var objects = [AstroidObject]()
                    for key in neoFeed.nearEarthObjects.keys {
                        objects.append(AstroidObject(date: key, astroids: neoFeed.nearEarthObjects[key]))
                    }
                    DispatchQueue.main.async {
                        completion(objects)
                    }
                    
                } catch {
                    completion(nil)
                }
            }.resume()
    }
}
