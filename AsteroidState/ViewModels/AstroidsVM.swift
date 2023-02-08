//
//  AstroidsVM.swift
//  AsteroidState
//
//  Created by Sanjay Thakkar on 06/02/23.
//

import Foundation
import ProgressHUD
class AstroidsVM {
    
    var fromDate:Date?
    var toDate:Date?
    
    var astroids:[AstroidObject]?
    var sortedAstroids:[AstroidObject]?
    var differentAstroids:[eTypeOfAstroid]?
    
    ///Get All Astroids with completion block
    func getAstroids(completion:@escaping ()->()) {
        ProgressHUD.show("fetching data...")
        APIManager.getAstroids(withRange: fromDate!, to: toDate!) { data in
            ProgressHUD.dismiss()
            self.astroids = data
            self.sortedAstroids = data!.sorted{ $0.date!.toDate() < $1.date!.toDate() }
            self.differentAstroids = self.getAllTypesStats()
            completion()
        }
    }
    
    ///Validate if the user have selected from date to to date
    func validateTheRange() -> Bool {
        fromDate != nil && toDate != nil
    }
    
    ///Parsing the general array for different stats
    private func getAllTypesStats() -> [eTypeOfAstroid] {
        var arr = [eTypeOfAstroid]()
        let fastest = astroids?.sorted(by: { obj1, obj2 in
            return obj1.fastestAmong().speed() > obj2.fastestAmong().speed()
        }).first!
        let closest = astroids?.sorted(by: { obj1, obj2 in
            return obj1.closestAmong().closeDate() > obj2.closestAmong().closeDate()
        }).first!
        
        let allAstroid = astroids!.flatMap{ $0.astroids! }
        let avg = allAstroid.map{ $0.avgDiameter() }.reduce(0, + ) / Double(allAstroid.count)
        
        arr.append(.fastest(date: fastest!.date!, speed: fastest!.fastestAmong().closeApproachData.first!.relativeVelocity.kilometersPerSecond, id: fastest!.fastestAmong().id))
        
        arr.append(.closes(date: closest!.date!, distance: closest!.closestAmong().distance(), id: closest!.closestAmong().id))
        
        arr.append(.average(diameter: String(avg)))
        return arr
    }
    
    
    
}
