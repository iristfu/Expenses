//
//  ExpenseRow.swift
//  Expenses (iOS)
//
//  Created by Iris Fu on 5/25/21.
//

import SwiftUI

struct ExpenseRow: View {
    var expense: Expense
    var body: some View {
        HStack {
            VStack {
                Text(expense.name )
                HStack {
                    Text(dateToString(date: expense.date ))
                    Text(expense.category )
                }
            }
            Spacer()
            Text(expense.amount )
        }
    }
}
