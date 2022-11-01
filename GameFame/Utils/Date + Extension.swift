//
//  Date + Extension.swift
//  GameFame
//
//  Created by Erdem Papakçı on 1.11.2022.
//

import Foundation

extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}
