//
//  NetworkError.swift
//  GameFame
//
//  Created by Erdem Papakçı on 1.11.2022.
//

import Foundation

enum NetworkError: Error {
    
    case ErrorDecoding
    case unknownError
    case invalidUrl
    case emptyData
    
    var errorDescription: String? {
        
        switch self {
        case .ErrorDecoding:
            return "Response could not decoded"
        case .unknownError:
            return "Error "
        case .invalidUrl:
            return "Url is wrong"
            
        case .emptyData:
            return "Value is empty"
        }
    }
    
}

