//
//  NetworkClient.swift
//  PostViewer
//
//  Created by Sebastian Bonilla on 17/02/21.
//  Copyright © 2021 Sebastian Bonilla. All rights reserved.
//

import Foundation

class NetworkClient: Client {
    var session: URLSession = URLSession(configuration: .default)
    
    func fetch<T>(api: API, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        do {
            let request = try api.asURLRequest()
            let dataTask = session.dataTask(with: request) { (data, response, error) in
                guard let validData = data, error == nil else {
                    DispatchQueue.main.async {
                        completion(.failure(error!))
                    }
                    return
                }
                
                do{
                    let json = try JSONDecoder().decode(T.self, from: validData)
                    DispatchQueue.main.async {
                        completion(.success(json))
                    }
                }catch let error {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            }
            
            dataTask.resume()
        } catch let error {
            DispatchQueue.main.async {
                completion(.failure(error))
            }
        }
    }
}
