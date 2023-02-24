//
//  TransactionTrackerViewModel.swift
//  EmbarqueTenaresInternalApp
//
//  Created by Elkin Garcia on 2/18/23.
//

import Foundation
class TransactionTrackerViewModel: ObservableObject {
    @Published var transactions : [Transaction] = []
    @Published var searchText : String = ""
    
    func getAllTransactions(){
        let defaults = UserDefaults.standard
        
        guard let token = defaults.string(forKey: "jsonwebtoken") else {
            print("Return to log in view")
            return
        }
        
        WebService().getAllTransactions(token: token){ (result) in
            switch result {
            case .success(let t):
                DispatchQueue.main.async {
                    self.transactions = t
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    var searchResults: [Transaction] {
        if searchText.isEmpty {
            return transactions
        } else {
            var trans = [Transaction]()
            for i in 0...transactions.count-1 {
                if(transactions[i].name.contains(searchText) || String(transactions[i].amount).contains(searchText) || String(transactions[i].invoice).contains(searchText) ||  String(transactions[i].receipt).contains(searchText) || transactions[i].date.contains(searchText)){
                    trans.append(transactions[i])
                }
            }
            return trans
        }
    }
    
    func delete(selection : Set<Transaction>){
        // send request to database
    }
    
    func edit(transaction: Transaction){
        // send request to database
    }
    
    func addTransaction(transaction : Transaction){
        // send request to database
    }
}
