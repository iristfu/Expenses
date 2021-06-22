//
//  EditExpenseView.swift
//  Expenses (iOS)
//
//  Created by Iris Fu on 5/25/21.
//

import SwiftUI
import CoreData

struct EditExpenseView: View {
    var viewContext: NSManagedObjectContext

    @ObservedObject var expenseToEdit: Expense
    
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
            expenseToEdit.objectWillChange.send()
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
                TextField("Expense name", text: $expenseToEdit.name)
                    .themetext()
                    .animation(.easeInOut)
                    .padding()

                TextField("Amount", text: $expenseToEdit.amount)
                    .themetext()
                    .keyboardType(.decimalPad)
                    .padding()

                VStack() {
                    Text("Category")
                        .foregroundColor(.secondary)
                    Picker("Category", selection: $expenseToEdit.category) {
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
                    DatePicker(selection: $expenseToEdit.date, in: dateRange, displayedComponents: .date) {
                    }
                    .themetext()
                    .datePickerStyle(WheelDatePickerStyle())
                    .frame(height: 80)
                    .clipped()
                }

                TextField("Notes", text: $expenseToEdit.notes)
                    .themetext()
                    .padding()
            }
            .navigationTitle("Edit Expense")
            .toolbar {
                ToolbarItemGroup {
                    HStack {
                        cancelButton()
                        Divider()
                        saveButton()
                    }
                    
                }
            }
        }

    }
}
