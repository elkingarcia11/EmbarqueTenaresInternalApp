import SwiftUI

struct AddTransactionView: View {
    @Environment(\.presentationMode) var presentationMode
    
    enum Field: Hashable {
        case nameField
        case amountField
        case invoiceField
        case receiptField
        case dateField
    }
    
    private var transactionsViewModel : TransactionTrackerViewModel?
    
    @State private var name : String = ""
    @State private var amount : String = ""
    @State private var invoice : String = ""
    @State private var receipt : String = ""
    @State private var date : Date = Date()
    @FocusState private var focusedField: Field?
    
    
    init(viewModel : TransactionTrackerViewModel ) {
        transactionsViewModel = viewModel
        focusedField = .nameField
    }
    
    var body: some View {
        NavigationStack{
            List{
                Section(
                    footer:
                        HStack{
                            Button("Cancel"){
                                presentationMode.wrappedValue.dismiss()
                            }
                            .padding(.trailing)
                            .foregroundColor(Color.gray)
                            Button("Save"){
                                addTransaction()
                                presentationMode.wrappedValue.dismiss()
                            }
                            .padding(.leading)
                            .foregroundColor(Color.blue)
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.vertical)
                )
                {
                    TextField(
                        "Full name",
                        text: $name
                    )
                    .disableAutocorrection(true)
                    .focused($focusedField, equals: .nameField)
                    .onSubmit {
                        focusedField = .amountField
                    }
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
                    TextField(
                        "Invoice number",
                        text: $invoice
                    )
                    .disableAutocorrection(true)
                    .focused($focusedField, equals: .invoiceField)
                    .onSubmit {
                        focusedField = .receiptField
                    }
                    TextField(
                        "Receipt number",
                        text: $receipt
                    )
                    .disableAutocorrection(true)
                    .focused($focusedField, equals: .receiptField)
                    DatePicker(
                        "Date processed",
                        selection: $date,
                        displayedComponents: [.date]
                    )
                    .foregroundColor(Color(UIColor.systemGray3))
                }
            }
            .navigationTitle("Add Transaction")
        }
    }
    
    func addTransaction(){
        let dateFormatter = DateFormatter()
        dateFormatter.string(from: date)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let newDate = dateFormatter.string(from: date)
        let today = dateFormatter.string(from: Date.now)
        let transaction = Transaction(id: UUID().uuidString, name: self.name, invoice: Int(self.invoice)!, receipt: Int(self.receipt)!, amount: Int(self.amount)!, dateProcessed: newDate, date: today)
        transactionsViewModel?.addTransaction(transaction: transaction)
    }
}
