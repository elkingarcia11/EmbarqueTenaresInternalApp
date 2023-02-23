//
//  ContentView.swift
//  EmbarqueTenaresInternalApp
//
//  Created by Elkin Garcia on 2/17/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var loginViewModel = LoginViewModel()
    var body: some View {
        if(loginViewModel.isAuthenticated){
            TransactionTrackerView()
        } else {
            LoginView(loginViewModel: loginViewModel)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
