//
//  NetworkServiceProtocol.swift
//  GameFame
//
//  Created by Erdem Papakçı on 19.10.2022.
//

import Foundation

protocol NetworkServiceProtocol{
  
    func fetchGameWithPage<T: Decodable>(_ type: T.Type, with page: Int, completion: @escaping(Result<T,NetworkError>) -> Void)
    func fetchGameNews<T: Decodable>(type: T.Type, completion: @escaping(Result<T,NetworkError>) -> Void)
    func fetchGameDetails<T: Decodable>(_ type:T.Type, url: String, gameID: String, completion: @escaping(Result<T,NetworkError>) -> Void)
    
}

