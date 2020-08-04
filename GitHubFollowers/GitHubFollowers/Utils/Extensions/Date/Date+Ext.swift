//
//  Date+Ext.swift
//  GitHubFollowers
//
//  Created by Christian Slanzi on 04.08.20.
//  Copyright © 2020 Christian Slanzi. All rights reserved.
//

import Foundation

extension Date {

    func convertToMonthYearFormat() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM yyyy"

        return dateFormatter.string(from: self)
    }
}
