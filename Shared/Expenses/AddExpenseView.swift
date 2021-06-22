//
//  ExpenseView.swift
//  Expenses (iOS)
//
//  Created by Iris Fu on 5/25/21.
//

import SwiftUI
import CoreData

struct AddExpenseView: View {
    @Environment(\.managedObjectContext)
    var viewContext: NSManagedObjectContext
    
    @State private var name: String = ""
    @State private var amount: String = "$"
    @State private var date: Date = Date()
    @State private var notes: String = ""
    @State private var category: Category = .none

    @Environment(\.presentationMode) var presentationMode
    
    
    // source: Apple's Landmark Tutorial
    var dateRange: ClosedRange<Date> {
        let min = Calendar.current.date(byAdding: .year, value: -1, to: Date())!
        let max = Calendar.current.date(byAdding: .year, value: 1, to: Date())!
        return min...max
    }
    
    
    fileprivate func cancelButton() -> Button<Text> {
        Button("Cancel") {
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    fileprivate func saveButton() -> Button<Text> {
        Button("Save") {
            let newExpense = Expense(context: viewContext)
            newExpense.name = name
            newExpense.amount = amount
            newExpense.date = date
            newExpense.notes = notes
            newExpense.category = category.rawValue
            do {
                try viewContext.save()
            } catch(let error) {
                print("couldn't save expense update to CoreData: \(error.localizedDescription)")
            }
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Expense name", text: $name)
                    .themetext()
                    .padding()
                
                TextField("Amount", text: $amount)
                    .themetext()
                    .keyboardType(.decimalPad)
                    .padding()
                
                VStack() {
                    Text("Category")
                        .foregroundColor(.secondary)
                    Picker("Category", selection: $category) {
                        ForEach(Category.allCases) { category in
                            Text(category.rawValue).tag(category)
                                .themetext()
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(height: 80)
                    .clipped()
                }

                VStack() {
                    Text("Date")
                        .foregroundColor(.secondary)
                    DatePicker(selection: $date, in: dateRange, displayedComponents: .date) {
                    }
                    .themetext()
                    .datePickerStyle(WheelDatePickerStyle())
                    .frame(height: 80)
                    .clipped()
                }
                
                TextField("Notes", text: $notes)
                    .themetext()
                    .padding()
            }
            .navigationBarItems(leading: cancelButton(), trailing: saveButton())
            .navigationTitle("Add Expense")
            .navigationBarTitleDisplayMode(.inline)
        }

    }
}
