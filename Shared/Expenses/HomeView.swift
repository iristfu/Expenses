//
//  HomeView.swift
//  Expenses (iOS)
//
//  Created by Iris Fu on 5/25/21.
//

import SwiftUI
import CoreData

struct HomeView: View {
    @EnvironmentObject var profile: Profile
    
    @Environment(\.managedObjectContext) var viewContext
    
    @Environment(\.presentationMode) var presentationMode
    
    // bind expenses with fetch request
    @FetchRequest var expense: FetchedResults<Expense>
        
    // determine ordering of expenses in the homeview
    init(sortBy: NSSortDescriptor) {
        let fetch = NSFetchRequest<Expense>(entityName: Expense.entity().name ?? "")
        fetch.sortDescriptors = [sortBy]
        _expense = FetchRequest(fetchRequest: fetch)
    }
    
    @State private var addNewExpense: Bool = false
    @State private var editMode: EditMode = .inactive
    @State private var expenseToEdit: Expense?
    
    fileprivate func addButton() -> Button<Text> {
        return Button(action: {
            addNewExpense = true
        }) {
            Text("Add")
        }
    }

    fileprivate func getTotal() -> Double {
        var total: Float = 0.0
        for item in expense {
            let curAmount = item.amount
            total += getAmount(amount: curAmount)
        }
        return Double(total)
    }
    
    var body: some View {
        NavigationView {
            List {
                HStack {
                    Text("Current total: \(round(100*getTotal())/100)")
                        .themetext()
                }
                ForEach(expense, id: \.self) { expense in
                    NavigationLink(destination: EditExpenseView(viewContext: self.viewContext, expenseToEdit: expense)) {
                        ExpenseRow(expense: expense)
                            .animation(
                                .easeOut(duration: 0.5)
                        )
                    }
                    .onTapGesture {
                        expenseToEdit = (editMode == .active ? expense : nil)
                    }
                    .sheet(item: $expenseToEdit) { expense in
                        EditExpenseView(viewContext: self.viewContext, expenseToEdit: expense)
                    }
                }
                .onDelete { indexSet in
                    indexSet.forEach { index in
                        let expense = expense[index]
                        viewContext.delete(expense)
                    }
                    do {
                        try viewContext.save()
                    } catch(let error) {
                        print("couldn't save expense update to CoreData: \(error.localizedDescription)")
                    }
                }

            }
            .sheet(isPresented: $addNewExpense) {
                AddExpenseView(viewContext: self._viewContext)
            }
            .navigationBarTitle("\(profile.name)'s Expenses")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    withAnimation {
                        HStack {
                            addButton()
                            Divider()
                            EditButton()
                        }
                        .themetext()
                    }
                    if presentationMode.wrappedValue.isPresented,
                       UIDevice.current.userInterfaceIdiom != .pad {
                        Button("Close") {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
            }
            .environment(\.editMode, $editMode)
        }
    }
}
