//
//  TransactionRow.swift
//  EmbarqueTenaresInternalApp
//
//  Created by Elkin Garcia on 2/17/23.
//

import SwiftUI

struct TransactionRow: View {
    var transaction : Transaction
    
    @GestureState private var isDetectingLongPress = false
    @State private var completedLongPress = false
    
    @State private var isShowingPopover = false

    var longPress : some Gesture{
        LongPressGesture(minimumDuration: 1)
            .onEnded { finished in
                self.isShowingPopover = true
            }
        
    }
    
    var body: some View {
        VStack{
            HStack{
                Text(transaction.name.uppercased())
                    .font(.title2)
                Spacer()
                Text("$"+transaction.amount)
                    .font(.title2)
                    .foregroundColor(Color.green)
            }
            HStack{
                Text(transaction.receipt)
                    .font(.callout)
                    .foregroundColor(Color.gray)
                Spacer()
                Text(transaction.date)
                    .font(.callout)
                    .fontWeight(.bold)
                    .foregroundColor(Color.gray)
            }
            
        }
    }
}
