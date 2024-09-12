//
//  Router.swift
//  Chatrooms
//
//  Created by PATRICIA S SIQUEIRA on 05/09/24.
//

import UIKit

protocol Routing {
    func routeToRoot()
}


class Router {
    typealias Submodules = ()
    
    private weak var viewController: UIViewController?
    private let submodules: Submodules
    private let onLogout: () -> Void
    
    init(viewController: UIViewController, 
         submodules: Submodules,
         onLogout: @escaping () -> Void) {
        self.viewController = viewController
        self.submodules = submodules
        self.onLogout = onLogout
    }
    
}

extension Router: Routing {
    
    func routeToRoot() {
        self.onLogout()
    }
}
