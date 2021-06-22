////
////  VisualizedBar.swift
////  Expenses (iOS)
////
////  Created by Iris Fu on 6/7/21.
////
//
//import SwiftUI
//
//
//struct VisualizedBar: View {
//    @Binding var standardization: Float
//    @ObservedObject var expense: Expense
//
//    var body: some View {
//        GeometryReader { geometry in
//            ZStack(alignment: .leading) {
//                Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
//                    .opacity(0.3)
//                    .foregroundColor(moneyGreen)
//                Rectangle().frame(width: min(CGFloat(standardization) * geometry.size.width * CGFloat(getAmount(amount: expense.amount)), geometry.size.width), height: geometry.size.height)
//                        .foregroundColor(moneyGreen)
//                        .animation(.linear)
//
//            }.cornerRadius(45.0)
//        }
//    }
//}
//
//
//struct VisualizedBar_Previews: PreviewProvider {
//    static var previews: some View {
//        VisualizedBar(standardization: $Float(0.01), expense: Expense())
//    }
//}
