//
//  EditTransctionView.swift
//  EmbarqueTenaresInternalApp
//
//  Created by Elkin Garcia on 2/21/23.
//

import SwiftUI

struct EditTransctionView: View {
    private var transaction:Transaction
    @State private var fullname : String = ""
    @State private var amount : String = ""
    @State private var invoice : String = ""
    @State private var receipt : String = ""
    @FocusState private var nameFieldIsFocused : Bool
    
    init(transaction : Transaction) {
        self.transaction = transaction
        self.fullname = transaction.name
        self.amount = transaction.amount
        self.invoice = transaction.invoice
        self.receipt = transaction.receipt
        self.nameFieldIsFocused = nameFieldIsFocused
    }
    
    var body: some View {
        NavigationView{
            List{
                TextField(
                    "Full name",
                    text: $fullname
                )
                TextField(
                    "Amount paid",
                    text: $amount
                )
                
                TextField(
                    "Invoice number ",
                    text: $invoice
                )
                TextField(
                    "Receipt number ",
                    text: $receipt
                )
                
            }
            .navigationTitle("Edit Transaction")
        }
    }
}
