//
//  ExpenseModel.swift
//  Expenses (iOS)
//
//  Created by Iris Fu on 5/25/21.
//

import Foundation
import CoreData
import Combine

extension Expense {
    static func fetchRequest(_ predicate: NSPredicate) -> NSFetchRequest<Expense> {
        let request = NSFetchRequest<Expense>(entityName: "Expense")
        request.sortDescriptors = [NSSortDescriptor(key: "date_", ascending: true)]
        request.predicate = predicate
        return request
    }

    var name: String {
        get { name_ ?? "" } // TODO: protect against nil before shipping?
        set { name_ = newValue }
    }
    
    var date: Date {
        get { date_ ?? Date(timeIntervalSinceReferenceDate: 0) }
        set { date_ = newValue }
    }
    
    var category: String {
        get { category_ ?? ".none" }
        set { category_ = newValue }
    }
    var notes: String {
        get { notes_ ?? "" }
        set { notes_ = newValue }
    }
    var amount: String {
        get { amount_ ?? "0" }
        set { amount_ = newValue }
    }
}

enum Category: String, CaseIterable, Identifiable {
    case groceries
    case clothes
    case resturant
    case fun
    case rent
    case education
    case electronics
    case other
    case none
    
    var id: String { self.rawValue }
}

enum SortBy: String, CaseIterable {
    case date
    case amount
}

func dateToString(date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM/dd"
    return dateFormatter.string(from: date)
}
