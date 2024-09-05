//
//  LandingViewController.swift
//  Landing
//
//  Created by PATRICIA S SIQUEIRA on 03/09/24.
//

import UIKit

class LandingViewController: UIViewController {
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    var onStart: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @IBAction func onStartTapped(_ sender: Any) {
        onStart?()
    }
    
}

private extension LandingViewController {
    
    func setupUI() {
        logoImageView.image = UIImage(named: "connectedicon", in: Bundle(for: LandingViewController.self), with: nil)
        startButton.setImage(UIImage(systemName: "play.circle"), for: .normal)
        startButton.titleLabel?.text = ""
    }
}
