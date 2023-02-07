//
//  ViewControllerExtensions.swift
//  AsteroidState
//
//  Created by Sanjay Thakkar on 07/02/23.
//

import Foundation
import DatePicker

extension ViewController {
    func openDatePicker(minimum:Date? = nil, maximum:Date? = nil, sender:UIView, completion: @escaping (Date?)->()) {
        let today = Date()
        // Create picker object
        let datePicker = DatePicker()
        // Setup
        if let minimum = minimum, let maximum = maximum {
            datePicker.setup(beginWith: today, min: minimum, max: maximum) { (selected, date) in
                completion(date)
            }
        } else {
            datePicker.setup(beginWith: today) { (selected, date) in
                completion(date)
            }
        }
        // Display
        datePicker.show(in: self, on: sender)
    }
    
    
}

