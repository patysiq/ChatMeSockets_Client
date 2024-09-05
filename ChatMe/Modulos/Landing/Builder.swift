//
//  Builder.swift
//  Landing
//
//  Created by PATRICIA S SIQUEIRA on 03/09/24.
//

import UIKit
import Utility

public final class Builder {
    
    public static func build(completion: @escaping () -> Void) -> UIViewController {
        let storyboard = UIStoryboard.init(name: "Landing", bundle: Bundle(for: self))
        let view = LandingViewController.instatiate(from: storyboard)
        view.onStart = completion
        return view
    }
}
