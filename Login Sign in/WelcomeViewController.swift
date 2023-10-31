//
//  WelcomeViewController.swift
//  Login Sign in
//
//  Created by Natalia Shchipakina on 29.10.2023.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    var user: User
    
    //    MARK: - Init
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome, \(user.login) 👋!"
        label.textColor = .systemOrange
        label.font = .boldSystemFont(ofSize: 26)
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
    
    //    MARK: - UI
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(welcomeLabel)
    }
    
    func setupConstraints() {
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            welcomeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            welcomeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
    
}
