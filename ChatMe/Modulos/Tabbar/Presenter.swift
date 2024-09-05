//
//  Presenter.swift
//  Tabbar
//
//  Created by PATRICIA S SIQUEIRA on 05/09/24.
//

import Foundation

protocol Routing {
    
}

class Presenter: Presentation {
    
    weak var view: TabbarView?
    typealias UseCases = ()
    var useCases: UseCases
    
    init(useCases: UseCases) {
        self.useCases = useCases
    }
}
