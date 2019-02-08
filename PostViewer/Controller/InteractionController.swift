//
//  InteractionController.swift
//  PostViewer
//
//  Created by Sebastian Bonilla on 3/02/19.
//  Copyright © 2019 Sebastian Bonilla. All rights reserved.
//

import Foundation
import UIKit

class AppInteractionController {
    
    public static var shared: AppInteractionController = AppInteractionController()
//    private var viewControllers: [UIViewController] = []
    private var PostNetworkController: AlamofirePostDataController = AlamofirePostDataController()
    
//    func addController(_ controller: UIViewController) {
//        self.viewControllers.append(controller)
//    }
    
    func getControllerData<T: UIData>(_ completion: @escaping(_ data: T) -> Void) {
        switch T.self {
        case is ControllerData.Type:
            PostNetworkController.getAll { (posts) in
                guard let posts = posts else {
                    completion(T(list: []))
                    return
                }
                
                let uiPosts = posts.compactMap({ UIPost($0) })
                completion(T(list: uiPosts))
            }
        default:
            break
        }
    }
    
    func goToPostDetail(from controller: UIViewController, with post: UIPost, completion: @escaping(_ controllerToPresent: UIViewController) -> Void) {
        let viewControllerName = String(describing: ContentViewController.self)
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        completion(storyboard.instantiateViewController(withIdentifier: viewControllerName))
    }
    
}

