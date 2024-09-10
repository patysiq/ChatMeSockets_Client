//
//  ProfileViewController.swift
//  Profile
//
//  Created by PATRICIA S SIQUEIRA on 05/09/24.
//

import UIKit
import RxSwift

class ProfileViewController: UIViewController {
    
    private var presenter: Presentation!
    var presenterProducer: Presentation.Producer!
    private let bag = DisposeBag()
    
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
        presenter.output.username
            .drive(self.profileLabel.rx.text)
            .disposed(by: bag)
        
        presenter.output.email
            .drive(self.emaillabel.rx.text)
            .disposed(by: bag)
    }
}
