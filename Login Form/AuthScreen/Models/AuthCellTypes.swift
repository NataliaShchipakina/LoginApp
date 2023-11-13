//
//  AuthCellTypes.swift
//  Login Form
//
//  Created by Natalia Shchipakina on 06.11.2023.
//

import Foundation

enum AuthCellTypes {
    case textField(TextFieldTableViewCellViewModel, reuseID: Int)
    case leftLabelRightSwitch(LeftLabelRightSwitchTableViewCellViewModel, reuseID: Int)
    case button(ButtonTableViewCellViewModel, reuseID: Int)
}
