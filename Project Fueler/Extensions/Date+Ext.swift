//
//  Date+Ext.swift
//  Project Fueler
//
//  Created by Murat Baykor on 12.02.2020.
//  Copyright © 2020 Murat Baykor. All rights reserved.
//

import Foundation

extension Date {
    
    func stringFromDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy HH:mm"
        return formatter.string(from: self)
    }
    
}
