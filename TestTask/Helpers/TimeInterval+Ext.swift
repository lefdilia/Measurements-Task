//
//  TimeInterval+Ext.swift
//  TestTask
//
//  Created by Lefdili Alaoui Ayoub on 12/4/2022.
//

import UIKit


extension TimeInterval {
    
    func toReadable(format: String = "MMMM dd, yyyy - HH:mm:ss") -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        let myDate = Date(timeIntervalSince1970: self)
        let dateString = formatter.string(from: myDate)
        
        return dateString.capitalized
    }
    
}
