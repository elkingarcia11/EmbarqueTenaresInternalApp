//
//  TransactionTrackerViewModel.swift
//  EmbarqueTenaresInternalApp
//
//  Created by Elkin Garcia on 2/18/23.
//

import Foundation
class TransactionTrackerViewModel: ObservableObject {
    @Published var transactions : [Transaction]
    @Published var searchText : String
    
    init(){
        self.searchText = ""
        self.transactions = [Transaction]()
        /*for list of transactions, make a list for names, amount, receipt, and date for search functionality*/
        let transactionOne = Transaction( name: "elkin garcia", amount: "125", invoice: "6542354", receipt: "5648", date: "2023-01-25")
        let transactionTwo = Transaction( name: "elkin rodriguez", amount: "300", invoice: "6542354", receipt: "4762", date: "2023-02-15")
        let transactionThree = Transaction(name: "Rosanna rodriguez", amount: "250",  invoice: "6542354",receipt: "4762", date: "2023-02-15")
        let transactionFour = Transaction(name: "guillermo rodriguez", amount: "100",  invoice: "6542354", receipt: "12345", date: "2022-01-10")
        
        transactions.append(transactionOne)
        transactions.append(transactionTwo)
        transactions.append(transactionThree)
        transactions.append(transactionFour)
    }
    
    var searchResults: [Transaction] {
           if searchText.isEmpty {
               return transactions
           } else {
               var trans = [Transaction]()
               for i in 0...transactions.count-1 {
                   if(transactions[i].name.contains(searchText) || transactions[i].amount.contains(searchText) || transactions[i].invoice.contains(searchText) ||  transactions[i].receipt.contains(searchText) || transactions[i].date.contains(searchText)){
                       trans.append(transactions[i])
                   }
               }
               return trans
           }
       }
    
    func delete(selection : Set<Transaction>){
        // send request to database
    }
    
    func edit(transaction: Transaction, id: UUID){
        // send request to database
    }
    
    func addTransaction(transaction : Transaction){
        // send request to database
    }
}
