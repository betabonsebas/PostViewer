//
//  PersistenceController.swift
//  PostViewer
//
//  Created by Sebastian Bonilla on 3/02/19.
//  Copyright © 2019 Sebastian Bonilla. All rights reserved.
//

import Foundation

class PListDataController {
    private var baseURL: URL {
        let paths = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        return paths.appendingPathComponent("data.plist")
    }
    
    func getAll(completion: @escaping ([UIPost]?) -> ()) {
        if FileManager.default.fileExists(atPath: baseURL.path) {
            guard let data = try? Data(contentsOf: baseURL), let post = try? PropertyListDecoder().decode([UIPost].self, from: data) else {
                completion(nil)
                return
            }
            completion(post)
            return
        }
        completion(nil)
    }
    
    func save(_ models: [UIPost], completion: @escaping (Bool) -> ()) {
        var data: [String: Any] = [:]
        data["posts"] = models
        do {
            let plistData = try PropertyListEncoder().encode(models)
            try plistData.write(to: baseURL)
            completion(true)
        } catch let error {
            print(error.localizedDescription)
            completion(false)
        }
    }

    func update(_ model: UIPost, completion: @escaping (Bool) -> Void) {
        self.getAll { [weak self] posts in
            guard let newPosts = posts?.compactMap({ post -> UIPost? in
                return post.post.id == model.post.id ? model : post
            }) else {
                completion(false)
                return
            }
            self?.save(newPosts, completion: completion)
        }
    }
    
    func delete(id: Int, completion: @escaping (Bool) -> ()) {
        self.getAll { [weak self] posts in
            guard let newPosts = posts?.compactMap({ post -> UIPost? in
                return post.post.id == id ? nil : post
            }) else {
                completion(false)
                return
            }
            self?.save(newPosts, completion: completion)
        }
    }
    
    func deleteAll() {
        var data: [String: Any] = [:]
        data["posts"] = nil
        do {
            let plistData = try? PropertyListSerialization.data(fromPropertyList: [UIPost](), format: .xml, options: 0)
            try plistData?.write(to: baseURL)
        } catch _ {
            print("deleted error")
        }
    }
    
}
