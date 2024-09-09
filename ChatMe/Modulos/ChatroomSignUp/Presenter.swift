//
//  Presenter.swift
//  Chatrooms
//
//  Created by PATRICIA S SIQUEIRA on 05/09/24.
//

import Foundation
import RxSwift
import RxCocoa
import UseCases
import Models

protocol Presentation {
    typealias Input = (
        email: Driver<String>,
        username: Driver<String>,
        password: Driver<String>,
        signup: Driver<Void>,
        backToLogin: Driver<Void>
    )
    typealias Output = (
        enableSignUp: Driver<Bool>, ()
    )
    typealias Producer = (Presentation.Input) -> Presentation
    
    var input: Input { get }
    var output: Output { get }
}

class Presenter: Presentation {
    
    var input: Input
    var output: Output
    
    typealias UseCases = (
        signUp: (_ email: String, _ username: String, _ password: String) -> Single<()>, ()
    )
    
    //private let dependencias: Dependencias
    private let useCases: UseCases
    private let router: Routing
    
    private let bag = DisposeBag()
    
    //typealias Dependencias = (router: Routing, useCases: UseCases)
    
    init(input: Input, router: Routing, useCases: UseCases) {
        self.input = input
        self.output = Presenter.output(input: self.input)
        self.router = router
        self.useCases = useCases
        self.process()
    }
}

private extension Presenter {
   static func output(input: Input) -> Output {
       
       let enableSignUpDriver = Driver.combineLatest(input.email.map({ $0.isEmail() }),
                                                     input.username.map({ !$0.isEmpty }),
                                                    input.password.map({ !$0.isEmpty })).map({ $0 && $1 && $2 })
       
        return (
            enableSignUp: enableSignUpDriver, ()
        )
    }
    
    func process() {
        
        self.input.signup
            .withLatestFrom(Driver.combineLatest(self.input.email, self.input.username, self.input.password))
            .debug("Sign Up Driver", trimOutput: false)
            .asObservable()
            .flatMapLatest({ [useCases] (email, username, password) in
                useCases.signUp(email, username, password).catch { (error) ->
                    Single<()> in
                    
                    if let error = error as? ChatroomsErrors {
                        print(error.errorDescription ?? "")
                    }
                    return .never()
                }
            })
            .map({ [router] (_) in
                router.routeToChatrooms()
            })
            .asDriver(onErrorDriveWith: .never())
            .drive()
            .disposed(by: bag)
        
        
        self.input.backToLogin
            .map({ [router] (_) in
                router.routeToLogin()
            })
            .drive()
            .disposed(by: bag)
    }
}
