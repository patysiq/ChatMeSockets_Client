//
//  Router.swift
//  ChatroomLogin
//
//  Created by PATRICIA S SIQUEIRA on 04/09/24.
//

import UIKit

class Router {
    
    private weak var viewController: UIViewController?
    private let onLogin: () -> Void
    
    init(viewController: UIViewController, onLogin: @escaping () -> Void) {
        self.viewController = viewController
        self.onLogin = onLogin
    }
}

extension Router: Routing {
    
    func routeToWindow() {
        onLogin()
    }
    
}
