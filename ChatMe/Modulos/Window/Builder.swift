//
//  Builder.swift
//  Window
//
//  Created by PATRICIA S SIQUEIRA on 03/09/24.
//

import UIKit
import Landing
import ChatroomLogin
import ChatroomSignUp
import Tabbar

public final class Builder {
    
    public static func build(windowScene: UIWindowScene) -> UIWindow {
        let window = Window(windowScene: windowScene)
        
        let landingModule = Landing.Builder.build
        let loginModule = ChatroomLogin.Builder.build
        let tabbarModule = Tabbar.Builder.build
        let signUpModule = ChatroomSignUp.Builder.build
        
        let router = Router(
            window: window,
            submodules: (
                landingModule: landingModule,
                loginModule: loginModule,
                signUpModule: signUpModule,
                tabbarModule: tabbarModule
                )
        )
        let presenter = Presenter(router: router)
        window.presenter = presenter
        
        return window
    }
    
}
