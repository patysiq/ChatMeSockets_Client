//
//  UiViewController+Extensions.swift
//  Utility
//
//  Created by PATRICIA S SIQUEIRA on 03/09/24.
//

import UIKit

public extension UIViewController {
    class func instantiate<T: UIViewController>(from storyboard: UIStoryboard, identifier: String) -> T {
        return storyboard.instantiateViewController(withIdentifier: identifier) as!  T
    }
    
    class func instatiate(from storyboard: UIStoryboard ) -> Self {
        return instantiate(from: storyboard, identifier: String(describing: self))
    }
    
    class func instatiate() -> Self {
        let className = String(describing: self)
        return instantiate(from: UIStoryboard(name: className, bundle: Bundle(for: self)), identifier: className)
    }
}
