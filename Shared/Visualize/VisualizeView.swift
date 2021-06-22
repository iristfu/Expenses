//
//  TrendsView.swift
//  Expenses (iOS)
//
//  Created by Iris Fu on 5/25/21.
//

import SwiftUI
import CoreData

struct VisualizeView: View {

    @State var visualize: Bool = false
    
    var body: some View {
        VStack() {
            Text("Expenses visualized")
            Button(action: {
                withAnimation {
                    visualize.toggle()
                }

            }) {
                DollarSignView()
                    .imageScale(.large)
                    .foregroundColor(moneyGreen)
                    .rotationEffect(.degrees(visualize ? 360 : 0))
                    .scaleEffect(visualize ? 1.3 : 1)
                    .padding()
            }
            Spacer()
            if visualize {
                VisualizedBudgetView(sortBy: NSSortDescriptor(keyPath: \Expense.date_, ascending: false))
                    .transition(.slide)
            } else {
                Text("Click dollar sign to view visualize expenses!")
                    .themetext()

            }
            Spacer()
        }
    }
}


struct TrendsView_Previews: PreviewProvider {
    static var previews: some View {
        VisualizeView()
    }
}
