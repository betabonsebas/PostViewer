//
//  Coordinator.swift
//  PostViewer
//
//  Created by Sebastian Bonilla on 17/02/21.
//  Copyright © 2021 Sebastian Bonilla. All rights reserved.
//

import UIKit

protocol Coordinator {
    var presenter: UINavigationController { get }
    
    func navigate()
}
