//
//  Transaction.swift
//  EmbarqueTenaresInternalApp
//
//  Created by Elkin Garcia on 2/17/23.
//

import Foundation

struct Transaction: Codable, Hashable{
    let id, name: String
    let invoice, receipt, amount: Int
    let dateProcessed, date: String

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case name, invoice, receipt, amount, dateProcessed, date
    }
}

struct TransactionResponse : Codable {
    let data : [Transaction]
}
