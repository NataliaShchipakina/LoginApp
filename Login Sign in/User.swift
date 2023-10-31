//
//  User.swift
//  Login Sign in
//
//  Created by Natalia Shchipakina on 29.10.2023.
//

import Foundation

struct User {
    let login: String
    let password: String
    
    static func getUserData() -> User {
        User(
            login: "User",
            password: "Password"
        )
    }
}
