//
//  Presenter.swift
//  Chatrooms
//
//  Created by PATRICIA S SIQUEIRA on 05/09/24.
//

import Foundation


protocol Presentation {
    typealias Input = ()
    typealias Output = ()
    typealias Producer = (Presentation.Input) -> Presentation
    
    var input: Input { get }
    var output: Output { get }
}

class Presenter : Presentation{
    
    var input: Input
    var output: Output
    
    typealias UseCases = (
        input: (),
        output: ()
    )
    private let dependencias: Dependencias
    private let useCases: UseCases
    private let router: Routing
    
    typealias Dependencias = (router: Routing, useCases: UseCases)
    
    init(input: Input, dependencias: Dependencias) {
        self.input = input
        self.dependencias = dependencias
        self.router = dependencias.router
        self.useCases = dependencias.useCases
        self.output = Presenter.output(input: self.input)
    }
}

private extension Presenter {
   static func output(input: Input) -> Output {
        return ()
    }
    
    func process() {
        
    }
}
