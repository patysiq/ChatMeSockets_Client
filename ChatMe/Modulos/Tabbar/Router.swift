//
//  Router.swift
//  Tabbar
//
//  Created by PATRICIA S SIQUEIRA on 05/09/24.
//

import UIKit

class Router {
    
    typealias Submodules = (
        chatrooms: UIViewController,
        friends: UIViewController,
        profile: UIViewController
    )
    
    private weak var viewController: UIViewController?
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
}

extension Router {
    static func tabs(usingSubmodules submodules: Submodules) ->  ChaMeTabs {
        let chatroomItem = UITabBarItem(title: "Chat", image: nil, tag: 100)
        submodules.chatrooms.tabBarItem = chatroomItem
        
        let friendItem = UITabBarItem(title: "Friends", image: nil, tag: 101)
        submodules.friends.tabBarItem = friendItem
        
        let profileItem = UITabBarItem(title: "Profile", image: nil, tag: 102)
        submodules.profile.tabBarItem = profileItem
        
        return (
            chatrooms: submodules.chatrooms,
            friends: submodules.friends,
            profile: submodules.profile
        )
    }
}

extension Router: Routing {
    
}
