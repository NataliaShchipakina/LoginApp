//
//  AuthViewController.swift
//  Login Form
//
//  Created by Natalia Shchipakina on 05.11.2023.
//

import UIKit

/*
 Список требований к лабораторной №1
 - Реализовать UI экрана через разные типы ячеек и enum
 - Segment control сделать через хедер таблицы
 - Верстка UI через NSLayoutConstraint
 - Сделать сохранение введенных данных в текстфилды, хранить их в UserDefaults. При повторном открытии введенные значения должны быть отображены
 */

class AuthViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - DataSource
    
    private let viewModelProvider: IAuthViewModelProvider
    private var screenDataModel: AuthScreenDataModel {
        didSet {
            dataSource = viewModelProvider.makeViewModel(screenDataModel: screenDataModel)
            if let encoded = try? JSONEncoder().encode(screenDataModel) {
                UserDefaults.standard.set(encoded, forKey: "AuthScreenDataModel")
            }
        }
    }
    private var dataSource: [AuthCellTypes]
    
    // MARK: - UI
        
    // TODO: - Поискать как сделать autolayout
    private lazy var headerView: AuthTableHeader = {
        let headerView = AuthTableHeader(frame: CGRect(x: 0, y: 0, width: 100, height: 70))
        return headerView
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(TextFieldTableViewCell.self,
                           forCellReuseIdentifier: TextFieldTableViewCell.identifier)
        tableView.register(LeftLabelRightSwitchTableViewCell.self,
                           forCellReuseIdentifier: LeftLabelRightSwitchTableViewCell.identifier)
        tableView.register(ButtonTableViewCell.self,
                           forCellReuseIdentifier: ButtonTableViewCell.identifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = 0
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        return tableView
    }()
    
    // MARK: - Init
    
    init(viewModelProvider: IAuthViewModelProvider) {
        self.viewModelProvider = viewModelProvider
        let screenDataModel: AuthScreenDataModel

        if let data = UserDefaults.standard.object(forKey: "AuthScreenDataModel") as? Data,
           let savedScreenData = try? JSONDecoder().decode(AuthScreenDataModel.self, from: data) {
            screenDataModel = savedScreenData
        } else {
            screenDataModel = AuthScreenDataModel(selectedState: .auth, login: nil, email: nil, password: nil, passwordConfirmation: nil, isOnAgreementPolicy: false)
        }
        
        self.screenDataModel = screenDataModel
        self.dataSource = viewModelProvider.makeViewModel(screenDataModel: screenDataModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.tableHeaderView = headerView
        headerView.delegate = self
        headerView.configure(with: AuthTableHeaderViewModel(selectedIndex: screenDataModel.selectedState.rawValue))
        setupUI()
        setupConstraints()
    }
    
    func setupUI() {
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellType = dataSource[indexPath.row]
        switch cellType {
        case .textField(let viewModel, let tag):
            let textFieldCell = tableView.dequeueReusableCell(
                withIdentifier: TextFieldTableViewCell.identifier
            ) as? TextFieldTableViewCell ?? TextFieldTableViewCell()
            textFieldCell.configure(with: viewModel)
            textFieldCell.delegate = self
            textFieldCell.tag = tag
            textFieldCell.selectionStyle = .none
            return textFieldCell
            
        case .leftLabelRightSwitch(let viewModel, let tag):
            let leftLabelRightSwitchCell = tableView.dequeueReusableCell(
                withIdentifier: LeftLabelRightSwitchTableViewCell.identifier
            ) as? LeftLabelRightSwitchTableViewCell ?? LeftLabelRightSwitchTableViewCell()
            leftLabelRightSwitchCell.configure(with: viewModel)
            leftLabelRightSwitchCell.delegate = self
            leftLabelRightSwitchCell.tag = tag
            leftLabelRightSwitchCell.selectionStyle = .none
            return leftLabelRightSwitchCell
            
        case .button(let viewModel, let tag):
            let button = tableView.dequeueReusableCell(
                withIdentifier: ButtonTableViewCell.identifier
            ) as? ButtonTableViewCell ?? ButtonTableViewCell()
            button.configure(with: viewModel)
            button.delegate = self
            button.tag = tag
            button.selectionStyle = .none
            return button
        }
    }
}

extension AuthViewController: AuthTableHeaderDelegate {
    func selectedIndexDidChange(currentIndex: Int) {
        guard let selectedState = AuthSelectedState(rawValue: currentIndex) else { return }
        screenDataModel.selectedState = selectedState
        tableView.reloadData()
    }
}

extension AuthViewController: TextFieldTableViewCellDelegate {
    func textDidChange(tag: Int, text: String?) {
        // TODO: Хрупкое место, порефакторить
        if tag == 0 {
            screenDataModel.login = text
        } else if tag == 1 {
            screenDataModel.password = text
        } else if tag == 4 {
            screenDataModel.email = text
        } else if tag == 5 {
            screenDataModel.passwordConfirmation = text
        }
    }
}

extension AuthViewController: LeftLabelRightSwitchTableViewCellDelegate {
    func switchDidChange(tag: Int, isOn: Bool) {
        screenDataModel.isOnAgreementPolicy = isOn
    }
}

extension AuthViewController: ButtonTableViewCellViewModelDelegate {
    func buttonDidTap(tag: Int) {
        // TODO: Хрупкое место, порефакторить
        if tag == 2 {
            print("Была нажата кнопка войти")
        } else if tag == 3 {
            print("Была нажата кнопка регистрация")
        }
    }
}
