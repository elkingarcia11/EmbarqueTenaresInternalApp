//
//  Transaction.swift
//  EmbarqueTenaresInternalApp
//
//  Created by Elkin Garcia on 2/17/23.
//

import Foundation

struct Transaction : Hashable, Identifiable {
    var id = UUID()
    var name : String
    var amount : String
    var invoice : String
    var receipt: String
    var date : String
    
}
