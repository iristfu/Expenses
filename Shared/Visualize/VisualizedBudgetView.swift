//
//  VisualizedBudgetView.swift
//  Expenses (iOS)
//
//  Created by Iris Fu on 6/7/21.
//

import SwiftUI
import CoreData

struct VisualizedBudgetView: View {
    
    @EnvironmentObject var profile: Profile
    
    @Environment(\.managedObjectContext) var viewContext
    
    // bind expenses with fetch request
    @FetchRequest var expense: FetchedResults<Expense>
    
    // determine ordering of expenses in the homeview
    init(sortBy: NSSortDescriptor) {
        let fetch = NSFetchRequest<Expense>(entityName: Expense.entity().name ?? "")
        fetch.sortDescriptors = [sortBy]
        _expense = FetchRequest(fetchRequest: fetch)
    }
    
    @State var standardization: Float = 0.01
    @State var scale: CGFloat = 1
   
    var body: some View {
        ScrollView {
            ForEach(expense, id: \.self) { expense in
                VStack {
                    Text(expense.name)
                        .themetext()
                    BudgetBar(standardization: $standardization, expense: expense).frame(height: 20)
                        .onAppear {
                            withAnimation(.easeInOut(duration: 1)) {
                                scale = 5
                            }
                        }
                        .onDisappear() {
                            withAnimation(.easeOut(duration: 1)) {
                                scale = 5
                            }
                        }
                }
            }
        }
    }
}

//Referenced https://www.simpleswiftguide.com/how-to-build-linear-progress-bar-in-swiftui/
struct BudgetBar: View {
    @Binding var standardization: Float
    @ObservedObject var expense: Expense

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                    .opacity(0.3)
                    .foregroundColor(moneyGreen)
                Rectangle().frame(width: min(CGFloat(standardization) * geometry.size.width * CGFloat(getAmount(amount: expense.amount)), geometry.size.width), height: geometry.size.height)
                        .foregroundColor(moneyGreen)
                        .animation(.linear)

            }.cornerRadius(45.0)
        }
    }
}

struct VisualizedBudgetView_Previews: PreviewProvider {
    static var previews: some View {
        VisualizedBudgetView(sortBy: NSSortDescriptor(keyPath: \Expense.date_, ascending: false))
    }
}
