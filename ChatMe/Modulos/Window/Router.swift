//
//  Router.swift
//  Window
//
//  Created by PATRICIA S SIQUEIRA on 03/09/24.
//

import UIKit

class Router {
    
    private unowned let window: UIWindow
    private let submodules: Submodules
    
    typealias Submodules = (
        landingModule: (_ onStart: @escaping () -> Void) -> UIViewController,
        loginModule: (_ onLogin: @escaping () -> Void) -> UIViewController,
        tabbarModule: () -> UIViewController
    )
    
    init(window: UIWindow, submodules: Submodules) {
        self.window = window
        self.submodules = submodules
    }
}




extension Router: Routing {
  
    func routeToLanding() {
        let landingView = self.submodules.landingModule { [weak self] in
            self?.routeToLogin()
        }
        self.window.rootViewController = landingView
        self.window.makeKeyAndVisible()
    }
    
    func routeToLogin() {
        let loginView = self.submodules.loginModule { [weak self] in
            print("Lauch tab bar from here")
            let tabbarView = self?.submodules.tabbarModule()
            self?.window.rootViewController = tabbarView
            self?.window.makeKeyAndVisible()
        }
        self.window.rootViewController = loginView
        self.window.makeKeyAndVisible()
    }
    
}
