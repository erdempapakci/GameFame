//
//  CoreDataError.swift
//  GameFame
//
//  Created by Erdem Papakçı on 20.10.2022.
//

import Foundation

enum CoreDataError: String,Error {
    case failedToSave = "Failed while saving"
    case failedToFetch = "Failed while fetching"
    case failedToDelete =  "Failed while deleting"
}
