//
//  UINavigationController+Extensions.swift
//  Utility
//
//  Created by PATRICIA S SIQUEIRA on 06/09/24.
//

import UIKit

public typealias NavigationFactory = (UIViewController) -> UINavigationController

extension UINavigationController {
    
    public static func build(rootView: UIViewController) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: rootView)
        navigationController.navigationBar.prefersLargeTitles = true
        
        return navigationController
    }
}
