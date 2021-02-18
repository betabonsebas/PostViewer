//
//  StoryboardInstantiable.swift
//  PostViewer
//
//  Created by Sebastian Bonilla on 17/02/21.
//  Copyright © 2021 Sebastian Bonilla. All rights reserved.
//

import UIKit

protocol StoryboardInstantiable {
    static func fromStoryboard() -> Self
}

extension StoryboardInstantiable where Self: UIViewController {

    static func fromStoryboard() -> Self {
        guard let name = description().components(separatedBy: ".").last?
            .replacingOccurrences(of: "ViewController", with: "") else {
                return Self.init(nibName: nil, bundle: nil)
        }

        let storyboard = UIStoryboard(name: name, bundle: nil)
        
        return storyboard.instantiateInitialViewController() as! Self
    }
}
