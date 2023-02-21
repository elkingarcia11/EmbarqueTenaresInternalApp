//
//  TransactionTrackerView.swift
//  EmbarqueTenaresInternalApp
//
//  Created by Elkin Garcia on 2/17/23.
//

import SwiftUI

struct TransactionTracker: View {
    @StateObject var transactionsViewModel = TransactionTrackerViewModel()
    
    @State private var completedLongPress = false
    @State private var singleSelected = false
    @State private var multipledSelected = false
    @State private var selectedTransactions : [Transaction] = []
    
    
    
    @State var isEditing = false
    @State private var selection = Set<Transaction>()

    var body: some View {
        ZStack{
            Color(UIColor.lightGray)
            NavigationView{
                NavigationStack {
                    List(transactionsViewModel.searchResults, id: \.self, selection: $selection){transaction in
                        TransactionRow(transaction: transaction)
                    }
                    .toolbar {
                        EditButton()
                    }
                    .navigationTitle("Transactions")
                    if(selection.count > 0){
                        Spacer()
                        HStack{
                            Button("Edit", action: {
                                transactionsViewModel.edit(selection: selection)
                            })
                                .padding(.leading)
                                .disabled(!(selection.count == 1))
                            Spacer()
                            Button("Delete", action: {
                                transactionsViewModel.delete(selection: selection)
                            })
                                .padding(.trailing)
                                .foregroundColor(Color.red)
                                .disabled(!(selection.count > 0))
                        }
                        
                    }
                    
                }
                .searchable(text: $transactionsViewModel.searchText)
            }
            
        }
    }
    
    func delete(at offsets: IndexSet) {
        transactionsViewModel.transactions.remove(atOffsets: offsets)
    }
}
