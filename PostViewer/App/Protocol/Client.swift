//
//  NetworkClientProtocol.swift
//  PostViewer
//
//  Created by Sebastian Bonilla on 17/02/21.
//  Copyright © 2021 Sebastian Bonilla. All rights reserved.
//

import Foundation

protocol Client {
    func fetch<T: Decodable>(api: API, completion: @escaping (Result<T, Error>) -> Void)
}
