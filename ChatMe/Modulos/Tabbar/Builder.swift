//
//  Builder.swift
//  Tabbar
//
//  Created by PATRICIA S SIQUEIRA on 05/09/24.
//

import UIKit

import Chatrooms
import Friends
import Profile

public final class Builder {
    
    public static func build() -> UITabBarController {
        let submodules: Router.Submodules = (
            chatrooms: Chatrooms.Builder.build(),
            friends: Friends.Builder.build(),
            profile: Profile.Builder.build()
        )
        let tabs: ChaMeTabs = Router.tabs(usingSubmodules: submodules)
        let presenter = Presenter(useCases: ())
        let view = ChatMeTabbarViewController(tabs: tabs)
        presenter.view = view
        view.presenter = presenter
        
        return view
    }
}
