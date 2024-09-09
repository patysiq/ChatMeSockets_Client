//
//  Router.swift
//  Chatrooms
//
//  Created by PATRICIA S SIQUEIRA on 05/09/24.
//

import UIKit

protocol Routing {
    func routeToLogin()
    func routeToChatrooms()
}


class Router {
    typealias Submodules = ()
    
    private weak var viewController: UIViewController?
    private let submodules: Submodules
    private let onSignUp: () -> Void
    private let swapLogin: () -> Void
    
    
    init(viewController: UIViewController,
         submodules: Submodules,
         onSignUp: @escaping () -> Void,
         swapLogin: @escaping () -> Void
        ) {
        self.viewController = viewController
        self.submodules = submodules
        self.onSignUp = onSignUp
        self.swapLogin = swapLogin
    }
    
}

extension Router: Routing {
    
    func routeToChatrooms() {
        self.onSignUp()
    }
    
    func routeToLogin() {
        self.swapLogin()
    }
    
}
