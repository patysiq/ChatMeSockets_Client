//
//  Builder.swift
//  Tabbar
//
//  Created by PATRICIA S SIQUEIRA on 05/09/24.
//

import UIKit
import Utility
import Chatrooms
import Friends
import Profile

public final class Builder {
    
    public static func build(onLogout: @escaping () -> Void) -> UITabBarController {
        let submodules: Router.Submodules = (
            chatrooms: Chatrooms.Builder.build(usingNavigationFactory: UINavigationController.build),
            friends: Friends.Builder.build(usingNavigationFactory: UINavigationController.build),
            profile: Profile.Builder.build(usingNavigationFactory: UINavigationController.build, onLogout: onLogout)
        )
        let tabs: ChaMeTabs = Router.tabs(usingSubmodules: submodules)
        let presenter = Presenter(useCases: ())
        let view = ChatMeTabbarViewController(tabs: tabs)
        presenter.view = view
        view.presenter = presenter
        
        return view
    }
}
