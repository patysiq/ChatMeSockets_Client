//
//  Builder.swift
//  Chatrooms
//
//  Created by PATRICIA S SIQUEIRA on 05/09/24.
//

import UIKit
import Utility
import UseCases

public final class Builder {
    
    public static func build(onSignUp: @escaping () -> Void, swapLogin: @escaping () -> Void) -> UIViewController {
        
        let storyboard = UIStoryboard(name: "ChatroomSingUp", bundle: Bundle(for: self))
        let view = SignUpViewController.instatiate(from: storyboard)
        
        let accountInteractor = UseCasesFactory.accountsInteractor
        
        let submodules: Router.Submodules = ()
        let router = Router(
            viewController: view,
            submodules: submodules,
            onSignUp: onSignUp,
            swapLogin: swapLogin
        )
        
        view.presenterProducer = {
            Presenter.init(
                input: $0,
                router: router,
                useCases: (
                    signUp: accountInteractor.signUp, ()
                )
            )
        }
        
        return view
    }
    
}
