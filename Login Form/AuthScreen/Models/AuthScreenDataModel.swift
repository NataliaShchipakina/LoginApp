//
//  AuthScreenDataModel.swift
//  Login Form
//
//  Created by Natalia Shchipakina on 13.11.2023.
//

import Foundation

struct AuthScreenDataModel: Codable {
    var selectedState: AuthSelectedState
    var login: String?
    var email: String?
    var password: String?
    var passwordConfirmation: String?
    var isOnAgreementPolicy: Bool
}

enum AuthSelectedState: Int, Codable {
    case auth
    case signUp
}
