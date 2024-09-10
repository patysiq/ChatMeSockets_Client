//
//  Presenter.swift
//  Chatrooms
//
//  Created by PATRICIA S SIQUEIRA on 05/09/24.
//

import Foundation
import RxSwift
import RxCocoa
import Models

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
        input: (
            fetchChatrooms: () -> Completable, ()
        ),
        output: (
            chatrooms: Observable<[Chatroom]>, ()
        )
    )
    private let bag = DisposeBag()
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
        self.process()
    }
}

private extension Presenter {
   static func output(input: Input) -> Output {
        return ()
    }
    
    func process() {
        self.useCases.input
            .fetchChatrooms()
            .debug("FetchChatrooms", trimOutput: false)
            .subscribe()
            .disposed(by: bag)
        
        self.useCases.output.chatrooms
            .debug("Chatrooms", trimOutput: false)
            .subscribe()
            .disposed(by: bag)
    }
}
