//
//  PersistenceController.swift
//  PostViewer
//
//  Created by Sebastian Bonilla on 3/02/19.
//  Copyright © 2019 Sebastian Bonilla. All rights reserved.
//

import Foundation

protocol PersistenceProtocol {
    associatedtype T
    func get(id: Int) -> T
    func getAll() -> [T]
    func save(dataModel: T)
    func update(dataModel: T)
    func delete(id: Int)
    func deleteAll()
}
