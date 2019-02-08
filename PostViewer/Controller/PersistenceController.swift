//
//  PersistenceController.swift
//  PostViewer
//
//  Created by Sebastian Bonilla on 3/02/19.
//  Copyright © 2019 Sebastian Bonilla. All rights reserved.
//

import Foundation

protocol DataProtocol {
    associatedtype T
    func get(id: Int, completion: @escaping(T?) -> ())
    func getAll(completion: @escaping([T]?) -> ())
    func save(_ models:[T], completion: @escaping (_ success: Bool) -> ())
    func delete(id: Int, completion: @escaping (_ success: Bool) -> ())
    func deleteAll()
}

class PListPostDataController: DataProtocol {
    private var baseURL: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return paths.appendingPathComponent("data.plist")
    }
    
    func get(id: Int, completion: @escaping (UIPost?) -> ()) {
        
    }
    
    func getAll(completion: @escaping ([UIPost]?) -> ()) {
        if FileManager.default.fileExists(atPath: baseURL.absoluteString) {
            guard let data = try? Data(contentsOf: baseURL), let post = try? JSONDecoder().decode([UIPost].self, from: data) else {
                completion(nil)
                return
            }
            completion(post)
        }
    }
    
    func save(_ models: [UIPost], completion: @escaping (Bool) -> ()) {
        var data: [String: Any] = [:]
        data["posts"] = models
        do {
            let plistData = try? PropertyListSerialization.data(fromPropertyList: models, format: .xml, options: 0)
            try plistData?.write(to: baseURL)
            completion(true)
        } catch _ {
            completion(false)
        }
        
    }
    
    func delete(id: Int, completion: @escaping (Bool) -> ()) {
        
    }
    
    func deleteAll() {
        
    }
    
    typealias T = UIPost
    
    
}
