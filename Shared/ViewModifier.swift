//
//  ViewModifier.swift
//  Expenses (iOS)
//
//  Created by Iris Fu on 6/6/21.
//

import SwiftUI

struct ThemeText: AnimatableModifier {

    func body(content: Content) -> some View {
        content
            .font(.callout)
            .foregroundColor(moneyGreen)
            .shadow(radius: 10)
            
    }
}

extension View {
    func themetext() -> some View {
        self.modifier(ThemeText())
    }
}




struct ViewModifier_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello, world")
            .themetext()
    }
}
