//
//  LoginViewModel.swift
//  EmbarqueTenaresInternalApp
//
//  Created by Elkin Garcia on 2/22/23.
//

import Foundation

class LoginViewModel: ObservableObject {
    func login(username : String , password : String) {
        WebService().login(username: username, password: password) {
            result in
            switch result {
            case .success (let token):
                print(token)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
