//
//  AuthViewModelProvider.swift
//  Login Form
//
//  Created by Natalia Shchipakina on 13.11.2023.
//

import Foundation

protocol IAuthViewModelProvider {
    func makeViewModel(screenDataModel: AuthScreenDataModel) -> [AuthCellTypes]
}

final class AuthViewModelProvider: IAuthViewModelProvider {
    func makeViewModel(screenDataModel: AuthScreenDataModel) -> [AuthCellTypes] {
        if screenDataModel.selectedState == .auth {
            return [
                .textField(TextFieldTableViewCellViewModel(placeholder: "Логин", text: screenDataModel.login), reuseID: 0),
                .textField(TextFieldTableViewCellViewModel(placeholder: "Пароль", text: screenDataModel.password), reuseID: 1),
                .button(ButtonTableViewCellViewModel(buttonText: "Войти"), reuseID: 2)
            ]
        } else if screenDataModel.selectedState == .signUp {
            return [
                .textField(TextFieldTableViewCellViewModel(placeholder: "Логин", text: screenDataModel.login), reuseID: 0),
                .textField(TextFieldTableViewCellViewModel(placeholder: "Email", text: screenDataModel.email), reuseID: 4),
                .textField(TextFieldTableViewCellViewModel(placeholder: "Пароль", text: screenDataModel.password), reuseID: 1),
                .textField(TextFieldTableViewCellViewModel(placeholder: "Подтвердите пароль", text: screenDataModel.passwordConfirmation), reuseID: 5),
                .leftLabelRightSwitch(LeftLabelRightSwitchTableViewCellViewModel(text: "Согласен с правилами", isOnAgreementSwitch: screenDataModel.isOnAgreementPolicy), reuseID: 6),
                .button(ButtonTableViewCellViewModel(buttonText: "Регистрация"), reuseID: 3)
            ]
        } else {
            return []
        }
    }
}
