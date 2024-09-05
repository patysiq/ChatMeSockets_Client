//
//  Presenter.swift
//  ChatroomLogin
//
//  Created by PATRICIA S SIQUEIRA on 04/09/24.
//

import Foundation
import RxSwift
import RxCocoa

protocol Routing {
    func routeToWindow()
}

class Presenter: Presentation {
    
    typealias UseCases = (
        login: ( _ username: String, _ email: String) -> Single<()>, ()
    )
    
    var input: Input
    var output: Output
    
    private let useCases: UseCases
    private let router: Routing
    
    private let bag = DisposeBag()
    
    init(input: Input, router: Routing, useCases: UseCases) {
        self.input = input
        self.useCases = useCases
        self.router = router
        self.output = Presenter.output(input: self.input)
        self.process()
    }
}

private extension Presenter {
    
    static func output(input: Input) -> Output {
        
        let enableLoginDriver = Driver.combineLatest(input.username.map({ !$0.isEmpty }),
                                                     input.email.map({ !$0.isEmpty && $0.isEmail() })).map({ $0 && $1 })
        
        return (
            enableLogin: enableLoginDriver, ()
        )
    }
    
    func process() {
        self.input.login
            .withLatestFrom(Driver.combineLatest(self.input.username , self.input.email))
            .asObservable()
            .flatMap({ [useCases] (username, email) in
                useCases.login(username, email)
            })
            .map({ [router] (_) in
                print("Login sucessful for user")
                router.routeToWindow()
            })
            .asDriver(onErrorDriveWith: .never())
            .drive()
            .disposed(by: bag)
        
    }
}
