//
//  Router.swift
//  Tabbar
//
//  Created by PATRICIA S SIQUEIRA on 05/09/24.
//

import UIKit

class Router {
    
    typealias Submodules = ()
    private weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
}

extension Router {
    static func tabs(usingSubmodules submodules: Submodules) ->  ChaMeTabs {
        return ()
    }
}

extension Router: Routing {
    
}
