//
//  String+Extension.swift
//  AsteroidState
//
//  Created by Sanjay Thakkar on 07/02/23.
//

import Foundation

extension Date {
    func toValidFormat() -> String {
        let df = DateFormatter()
        df.dateFormat = "YYYY-MM-dd"
        return df.string(from: self)
    }
}

extension String {
    func toValidFormat() -> Date {
        let df = DateFormatter()
        df.dateFormat = "YYYY-MMM-dd HH:mm"
        return df.date(from: self)!
    }
    
    func shortFormat() -> String {
        let df = DateFormatter()
        df.dateFormat = "YYYY-MM-dd"
        let date = df.date(from: self)
        df.dateFormat = "d, MMM"
        return df.string(from: date!)
    }
    
    func toDate() -> Date {
        let df = DateFormatter()
        df.dateFormat = "YYYY-MM-dd"
        return df.date(from: self)!
    }
}
