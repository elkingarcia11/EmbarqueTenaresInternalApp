//
//  LoginView.swift
//  EmbarqueTenaresInternalApp
//
//  Created by Elkin Garcia on 2/22/23.
//

import SwiftUI

struct LoginView: View {
    @Binding private var loginViewModel : LoginViewModel
    @State private var username : String = ""
    @State private var password : String = ""
    @State private var isShowingPassword : Bool = false
    @FocusState private var usernameFieldIsFocused: Bool
    @FocusState private var passwordFieldIsFocused: Bool
    
    var body: some View {
        ZStack{
            VStack{
                Label("Login", systemImage: "person.circle")
                    .padding(.vertical)
                    .foregroundColor(Color.blue)
                    .labelStyle(.iconOnly)
                    .font(.system(size: 50))
                VStack{
                    TextField("Username", text: $username)
                        .padding([.top, .leading, .bottom])
                        .background(Color.white)
                        .cornerRadius(5)
                        .focused($usernameFieldIsFocused)
                        .onSubmit {
                            usernameFieldIsFocused = false
                            passwordFieldIsFocused = true
                        }
                        .autocorrectionDisabled()
                    .autocapitalization(.none)
                }
                .padding(.bottom)
                VStack{
                    HStack{
                        if(isShowingPassword){
                            TextField("Password", text: $password)
                                .focused($passwordFieldIsFocused)
                                .onSubmit {
                                    passwordFieldIsFocused = false
                                    login()
                                }
                                .padding([.top, .leading, .bottom])
                                .autocorrectionDisabled()
                                .autocapitalization(.none)
                            
                            Button(action: {isShowingPassword.toggle()}){
                                Label("See Password", systemImage: "eye")
                                    .labelStyle(.iconOnly)
                            }
                            .padding(.trailing)
                            
                        } else {
                            SecureField("Password", text: $password)
                                .focused($passwordFieldIsFocused)
                                .onSubmit {
                                    passwordFieldIsFocused = false
                                    login()
                                }
                                .padding([.top, .leading, .bottom])
                                .autocorrectionDisabled()
                                .autocapitalization(.none)
                            
                            Button(action: {isShowingPassword.toggle()}){
                                Label("See Password", systemImage: "eye.slash")
                                    .labelStyle(.iconOnly)
                            }
                            .padding(.trailing)
                            
                        }
                    }
                    .background(Color.white)
                    .cornerRadius(5)
                    
                }
                .padding(.bottom)
                Button("Login"){
                    login()
                }
                .padding()
                .background(Color.white)
                .cornerRadius(5)
            }
            .padding()
            .background(Color(UIColor.systemGray5))
            .cornerRadius(5)
            
        }
        .padding(.horizontal)
    }
    
    func login(){
        loginViewModel.login(username: username, password: password)
    }
}
