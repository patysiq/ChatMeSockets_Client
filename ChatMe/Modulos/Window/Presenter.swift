//
//  Presenter.swift
//  Window
//
//  Created by PATRICIA S SIQUEIRA on 03/09/24.
//

import Foundation

protocol Routing {
    func routeToLanding()
    func routeToLogin()
}

class Presenter: Presentation {
    
    private let router: Routing
    
    init(router: Routing) {
        self.router = router
        process()
    }
}

private extension Presenter {
    
    func process() {
        self.router.routeToLanding()
    }
}
