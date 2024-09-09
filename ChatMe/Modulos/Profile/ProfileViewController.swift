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
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var profileLabel: UILabel!
    @IBOutlet weak var emaillabel: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter = presenterProducer(())
        setupUI()
        setupBinding()
    }

}

private extension ProfileViewController {
    
    func setupUI() {
        profileImageView.image = UIImage(named: "female", in: Bundle(for: ProfileViewController.self), with: nil)
    }
    
    func setupBinding() {
        
    }
}
