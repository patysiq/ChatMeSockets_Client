//
//  ProfileViewController.swift
//  Profile
//
//  Created by PATRICIA S SIQUEIRA on 05/09/24.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private var presenter: Presentation!
    var presenterProducer: Presentation.Producer!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = presenterProducer(())
        setupUI()
        setupBinding()
    }

}

private extension ProfileViewController {
    
    func setupUI() {
        
    }
    
    func setupBinding() {
        
    }
}
