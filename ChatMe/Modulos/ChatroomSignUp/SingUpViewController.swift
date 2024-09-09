//
//  SigUpViewController.swift
//  ChatroomSignUp
//
//  Created by PATRICIA S SIQUEIRA on 08/09/24.
//

import UIKit
import RxSwift
import RxCocoa

class SignUpViewController: UIViewController {
    
    private var presenter: Presentation!
    var presenterProducer: Presentation.Producer!
    private let bag = DisposeBag()
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signButton: UIButton!
    @IBOutlet weak var backToLoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.presenter = presenterProducer((
            email: emailTextField.rx.text.orEmpty.asDriver(),
            username: usernameTextField.rx.text.orEmpty.asDriver(),
            password: passwordTextField.rx.text.orEmpty.asDriver(),
            signup: signButton.rx.tap.asDriver(),
            backToLogin: backToLoginButton.rx.tap.asDriver()
        ))
        setupUI()
        setupBinding()
    }
    

}

private extension SignUpViewController {
    
    func setupUI() {
        imageView.image = UIImage(named: "female", in: Bundle(for: type(of: self)), with: nil)
        signButton.setImage(UIImage(systemName: "play.circle"), for: .normal)
        signButton.titleLabel?.text = ""
    }
    
    func setupBinding() {
        presenter.output.enableSignUp
            .drive(signButton.rx.isEnabled)
            .disposed(by: bag)
    }
}
