//
//  LoginViewModel.swift
//  EmbarqueTenaresInternalApp
//
//  Created by Elkin Garcia on 2/22/23.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var isAuthenticated : Bool = false
    
    func login(username : String , password : String) {
        
        let defaults = UserDefaults.standard
        WebService().login(username: username.lowercased(), password: password) {
            result in
            switch result {
            case .success (let token):
                defaults.setValue(token, forKey:"jsonwebtoken")
                DispatchQueue.main.async {
                    self.isAuthenticated = true
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
