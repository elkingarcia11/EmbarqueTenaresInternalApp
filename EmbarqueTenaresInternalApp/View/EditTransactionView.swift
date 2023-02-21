//
//  EditTransctionView.swift
//  EmbarqueTenaresInternalApp
//
//  Created by Elkin Garcia on 2/21/23.
//

import SwiftUI

struct EditTransactionView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    enum Field: Hashable {
        case nameField
        case amountField
        case invoiceField
        case receiptField
        case dateField
    }
    
    private var transactionsViewModel : TransactionTrackerViewModel?
    
    @State private var name : String
    @State private var amount : String
    @State private var invoice : String
    @State private var receipt : String
    @State private var date : Date = Date()
    @FocusState private var focusedField: Field?
    
    
    init(transactions : Set<Transaction>, viewModel : TransactionTrackerViewModel ) {
        
        transactionsViewModel = viewModel
        
        if let transaction = transactions.first {
            _name = State(initialValue: transaction.name)
            _amount =  State(initialValue: transaction.amount)
            _invoice =  State(initialValue: transaction.invoice)
            _receipt =  State(initialValue: transaction.receipt)
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
            dateFormatter.dateFormat = "yyyy-MM-dd"
            _date =  State(initialValue: dateFormatter.date(from:transaction.date)!)
        } else {
            
            _name = State(initialValue: "")
            _amount =  State(initialValue: "")
            _invoice =  State(initialValue: "")
            _receipt =  State(initialValue: "")
            _date = State(initialValue:  Date())
        }
        
    }
    
    var body: some View {
        NavigationView{
            NavigationStack{
                List{
                    Section(
                        header: HStack{
                            Text("Transaction Information")
                            .font(.headline)
                        .multilineTextAlignment(.center)
                            
                        }
                        .frame(maxWidth: .infinity),footer:
                            HStack{
                                Button("Cancel"){
                                    presentationMode.wrappedValue.dismiss()
                                }
                                    .padding(.trailing)
                                    .foregroundColor(Color.gray)
                                Button("Save"){
                                    presentationMode.wrappedValue.dismiss()
                                }
                                    .padding(.leading)
                                    .foregroundColor(Color.blue)
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical)
                    )
                    {
                        VStack(alignment: .leading){
                            Text("Name")
                                .foregroundColor(Color.gray)
                            TextField(
                                "Full name",
                                text: $name
                            )
                            .disableAutocorrection(true)
                            .focused($focusedField, equals: .nameField)
                            .onSubmit {
                                focusedField = .amountField
                            }
                            
                        }
                        
                        VStack(alignment: .leading){
                            Text("Amount paid")
                                .foregroundColor(Color.gray)
                            TextField(
                                "Amount paid",
                                text: $amount
                            )
                            .disableAutocorrection(true)
                            .focused($focusedField, equals: .amountField)
                            .foregroundColor(Color.green)
                            .onSubmit {
                                focusedField = .invoiceField
                            }
                        }
                        
                        VStack(alignment: .leading){
                            Text("Invoice number")
                                .foregroundColor(Color.gray)
                            TextField(
                                "Invoice number",
                                text: $invoice
                            )
                            .disableAutocorrection(true)
                            .focused($focusedField, equals: .invoiceField)
                            .onSubmit {
                                focusedField = .receiptField
                            }
                        }
                        
                        VStack(alignment: .leading){
                            Text("Receipt number")
                                .foregroundColor(Color.gray)
                            TextField(
                                "Receipt number",
                                text: $receipt
                            )
                            .disableAutocorrection(true)
                            .focused($focusedField, equals: .receiptField)
                            
                        }
                        
                        VStack(alignment: .leading){
                            Text("Date processed")
                                .foregroundColor(Color.gray)
                            DatePicker(
                                "",
                                selection: $date,
                                displayedComponents: [.date]
                            )
                            .labelsHidden()
                            .foregroundColor(Color.gray)
                        }}
                }
            }
            .navigationTitle("Edit Transaction")
            
        }
    }
}
