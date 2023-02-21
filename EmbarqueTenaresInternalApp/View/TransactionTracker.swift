import SwiftUI

struct TransactionTracker: View {
    @Environment(\.editMode) private var editMode
    
    @StateObject var transactionsViewModel = TransactionTrackerViewModel()
    
    @State private var isShowingEditSheet = false
    @State private var isShowingAddSheet = false
    
    @State private var selection = Set<Transaction>()
    
    var body: some View {
        ZStack{
            NavigationStack {
                List(transactionsViewModel.searchResults, id: \.self, selection: $selection){transaction in
                    TransactionRow(transaction: transaction)
                }
                .navigationTitle("Transactions")
                .toolbar {
                    EditButton()
                }
                if(selection.count > 0) {
                    Spacer()
                    HStack{
                        Button("Edit", action: {
                            isShowingEditSheet.toggle()
                        })
                        .padding(.leading, 20.0)
                        .disabled(!(selection.count == 1))
                        .sheet(isPresented: $isShowingEditSheet) {
                            EditTransactionView( transactions: selection, viewModel: transactionsViewModel)
                        }
                        Spacer()
                        Button("Delete", action: {
                            transactionsViewModel.delete(selection: selection)
                        })
                        .padding(.trailing, 20.0)
                        .foregroundColor(Color.red)
                        .disabled(!(selection.count > 0))
                    }
                }
            }
            ZStack{
                VStack{
                    Spacer()
                    HStack{
                        Spacer()
                        Button(action:{ isShowingAddSheet.toggle()}
                        ) {
                            Label("Add",systemImage: "doc.badge.plus")
                                .font(.system(.largeTitle))
                                .frame(width: 77, height: 70)
                                .foregroundColor(Color.white)
                                .padding(.bottom, 7)
                        }
                        .background(Color.blue)
                        .cornerRadius(38.5)
                        .padding()
                        .shadow(color: Color.black.opacity(0.3),
                                radius: 3,
                                x: 3,
                                y: 3)
                        .labelStyle(.iconOnly)
                        .sheet(isPresented: $isShowingAddSheet) {
                            AddTransactionView(viewModel: transactionsViewModel)
                        }
                        
                    }.padding(.bottom).frame(maxWidth: .infinity)
                }
                .padding(.bottom)
            }
        }
        .searchable(text: $transactionsViewModel.searchText)
    }
    
}
