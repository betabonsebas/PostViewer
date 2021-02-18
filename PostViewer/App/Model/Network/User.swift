//
//  User.swift
//  PostViewer
//
//  Created by Sebastian Bonilla on 17/02/21.
//  Copyright © 2021 Sebastian Bonilla. All rights reserved.
//

import Foundation

struct User: Codable {
    var id: Int
    var name: String
    var email: String
    var phone: String
    var website: String
}
