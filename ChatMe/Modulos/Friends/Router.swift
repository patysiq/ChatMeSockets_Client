//
//  Router.swift
//  Chatrooms
//
//  Created by PATRICIA S SIQUEIRA on 05/09/24.
//

import UIKit

protocol Routing {
    
}


class Router {
    typealias Submodules = ()
    
    private weak var viewController: UIViewController?
    private let submodules: Submodules
    
    init(viewController: UIViewController, submodules: Submodules ) {
        self.viewController = viewController
        self.submodules = submodules
    }
    
}

extension Router: Routing {
    
}
