//
//  Presenter.swift
//  Chatrooms
//
//  Created by PATRICIA S SIQUEIRA on 05/09/24.
//

import UIKit
import RxSwift
import RxCocoa
import Models


protocol Presentation {
    typealias Input = (
        onLogout: Driver<Void> , ()
    )
    typealias Output = (
        username: Driver<String>,
        email: Driver<String>
    )
    typealias Producer = (Presentation.Input) -> Presentation
    
    var input: Input { get }
    var output: Output { get }
}

class Presenter : Presentation{
    
    var input: Input
    var output: Output
    
    typealias UseCases = (
        input: (
            logout: () -> Single<()>, ()
        ),
        output: (
            profileUser: Observable<User>, ()
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
        self.output = Presenter.output(input: self.input, useCases: self.useCases)
    }
}

private extension Presenter {
    static func output(input: Input, useCases: UseCases) -> Output {
        let profileUser = useCases.output.profileUser.map( { $0 }).asDriver(onErrorDriveWith: .never())
        return (
            username: profileUser.map( { $0.username ?? "" }),
            email: profileUser.map( { $0.email })
        )
    }
    
    func process() {
        self.input.onLogout
            .asObservable()
            .flatMap({ [useCases] _ in
                useCases.input.logout()
            })
            .map({ [router] (_) in
                router.routeToRoot()
            })
            .asDriver(onErrorDriveWith: .never())
            .drive()
            .disposed(by: bag)
            
    }
}
