//
//  Router.swift
//  Window
//
//  Created by PATRICIA S SIQUEIRA on 03/09/24.
//

import UIKit
import RxSwift
import RxCocoa

class Router {
    
    private unowned let window: UIWindow
    private let submodules: Submodules
    
    typealias Submodules = (
        landingModule: (_ onStart: @escaping () -> Void) -> UIViewController,
        loginModule: (_ onLogin: @escaping () -> Void, _ onSignUp: @escaping () -> Void) -> UIViewController,
        signUpModule: (_ onSignUp: @escaping () -> Void, _ swapLogin: @escaping () -> Void) -> UIViewController,
        tabbarModule: (_ onLogout: @escaping () -> Void) -> UIViewController
    )
    
    init(window: UIWindow, submodules: Submodules) {
        self.window = window
        self.submodules = submodules
    }
}

extension Router: Routing {
  
    func routeToLanding() ->  Single<Void> {
        return Single.create { (single) -> Disposable in
            let landingView = self.submodules.landingModule { [weak self] in
                single(.success(()))
            }
            self.window.rootViewController = landingView
            self.window.makeKeyAndVisible()
            return Disposables.create()
        }
    }
    
    func routeToLogin() -> Single<RouteTo> {
        return Single.create { (single) -> Disposable in
            let loginView = self.submodules.loginModule ({ [weak self] in
                ///On login complete, lauch the tab bar
                print("Lauch tab bar from here")
                single(.success(.chatrooms))
            }) { [weak self] in
                ///On swap sign up, lauch tha sign up view
                single(.success(.singup))
                
            }
            self.window.rootViewController = loginView
            self.window.makeKeyAndVisible()
            return Disposables.create()
        }
    }
    
    func routeToSignUp() -> Single<RouteTo>{
        return Single.create { (single) -> Disposable in
            let signUpView = self.submodules.signUpModule ({ [weak self] in
                print("Lauch tab bar from here")
               // self?.routeToChatrooms()
            }) { [weak self] in
                //self?.routeToLogin()
            }
            self.window.rootViewController = signUpView
            self.window.makeKeyAndVisible()
            return Disposables.create()
        }
    }
    
    func routeToChatrooms() -> Single<Void> {
        return Single.create { (single) -> Disposable in
            let tabbarView = self.submodules.tabbarModule { [weak self] in
                //self?.routeToLogin()
            }
            self.window.rootViewController = tabbarView
            self.window.makeKeyAndVisible()
            return Disposables.create()
        }
       
    }
    
}
