//
//  ChatroomLoginViewController.swift
//  ChatroomLogin
//
//  Created by PATRICIA S SIQUEIRA on 03/09/24.
//

import UIKit
import RxSwift
import RxCocoa

protocol Presentation {
    typealias Input = (
        email: Driver<String>,
        password: Driver<String>,
        login: Driver<Void>,
        swapSignUp: Driver<Void>
    )
    typealias Output = (
        enableLogin: Driver<Bool>, ()
    )
    typealias Producer = (Presentation.Input) ->  Presentation
    
    var input: Input { get }
    var output: Output { get }
}

class ChatroomLoginViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var swapSignUpButton: UIButton!
    
    private var presenter: Presentation!
    var presenterProducer: Presentation.Producer!
    
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = presenterProducer((
            email: emailTextfield.rx.text.orEmpty.asDriver(),
            password: passwordTextfield.rx.text.orEmpty.asDriver(),
            login: loginButton.rx.tap.asDriver(),
            swapSignUp: swapSignUpButton.rx.tap.asDriver()
        ))
        setapUI()
        setupBinding()
    }
    
}

private extension ChatroomLoginViewController {
    
    func setapUI() {
        avatarImageView.image = UIImage(named: "female", in: Bundle(for: ChatroomLoginViewController.self), with: nil)
        loginButton.setImage(UIImage(systemName: "play.circle"), for: .normal)
        loginButton.titleLabel?.text = ""
    }
    
    func setupBinding() {
        
        presenter.output.enableLogin
            .drive(loginButton.rx.isEnabled)
            .disposed(by: bag)
    }
}
