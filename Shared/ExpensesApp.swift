//
//  ExpensesApp.swift
//  Shared
//
//  Created by Iris Fu on 5/24/21.
//

import SwiftUI

@main
struct ExpensesApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environmentObject(Profile())
        }
    }
}
