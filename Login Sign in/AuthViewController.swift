//
//  AuthViewController.swift
//  Login Sign in
//
//  Created by Natalia Shchipakina on 27.10.2023.
//

import UIKit


class AuthViewController: UIViewController {
    
    private let user = User.getUserData()
    
    // MARK: - UI
    
    private let segmentedControl: UISegmentedControl = {
        let segmentItems = ["Вход", "Регистрация"]
        let control = UISegmentedControl(items: segmentItems)
        control.addTarget(self, action: #selector(segmentedControl(_:)), for: .valueChanged)
        control.selectedSegmentIndex = 1
        control.translatesAutoresizingMaskIntoConstraints = false
        return control
    }()
    
    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [loginTextField, emailTextField, passwordTextField, repeatPasswordTextField])
        stackView.axis = .vertical
        stackView.spacing = 20
        return stackView
    }()
    
    private lazy var loginTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Логин"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "E-mail"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Пароль"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var repeatPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Повторить пароль"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [userAgreement, rulesSwitcher])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 8
        return stackView
    }()
    
    private lazy var userAgreement: UILabel = {
        let label = UILabel()
        label.text = "Согласен с правилами"
        return label
    }()
    
    private lazy var rulesSwitcher: UISwitch = {
        let switcher = UISwitch()
        return switcher
    }()
    
    private lazy var continueButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.layer.borderColor = .init(gray: 222/255, alpha: 0.5)
        button.setTitle("Зарегистрироваться", for: .normal)
        button.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        segmentedControl.selectedSegmentIndex = 1
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        view.addSubview(segmentedControl)
        view.addSubview(loginTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(repeatPasswordTextField)
        view.addSubview(verticalStackView)
        view.addSubview(horizontalStackView)
        view.addSubview(continueButton)
    }
    
    
    func setupConstraints() {
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        loginTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        repeatPasswordTextField.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        continueButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            
            verticalStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            verticalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            verticalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -26),
            
            horizontalStackView.topAnchor.constraint(equalTo: verticalStackView.bottomAnchor, constant: 16),
            horizontalStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            horizontalStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -26),
            
            continueButton.topAnchor.constraint(equalTo: horizontalStackView.bottomAnchor, constant: 16),
            continueButton.heightAnchor.constraint(equalToConstant: 30),
            continueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc func segmentedControl(_ segmentedControl: UISegmentedControl) {
        switch (segmentedControl.selectedSegmentIndex) {
        case 0:
            emailTextField.isHidden = true
            repeatPasswordTextField.isHidden = true
            horizontalStackView.isHidden = true
            continueButton.setTitle("Войти", for: .normal)
        case 1:
            emailTextField.isHidden = false
            repeatPasswordTextField.isHidden = false
            horizontalStackView.isHidden = false
            continueButton.setTitle("Зарегистрироваться", for: .normal)
        default:
            break
        }
    }
    
    @objc func continueButtonTapped() {
        
        guard
            loginTextField.text == user.login,
            passwordTextField.text == user.password
        else {
            showAlert(title: "Invalid login or password",
                      message: "Please, enter correct login and password",
                      textField: passwordTextField)
            return
        }
        
        let welcomeVC = WelcomeViewController(user: user)
        if let navigationController = self.navigationController {
            navigationController.pushViewController(welcomeVC, animated: true)
        }
    }
    
}

extension AuthViewController {
    private func showAlert(title: String, message: String, textField: UITextField? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            textField?.text = nil
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}


