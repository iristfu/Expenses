//
//  Profile.swift
//  Expenses (iOS)
//
//  Created by Iris Fu on 5/25/21.
//
//

import SwiftUI
import Combine

class Profile: ObservableObject {
    
    @Published var name = String() {
        didSet {
            storeNameInUserDefaults()
        }
    }
    
    @Published var budget = String() {
        didSet {
            storeBudgetInUserDefaults()
        }
    }
    
    private func storeNameInUserDefaults() {
        UserDefaults.standard.set(try? JSONEncoder().encode(name), forKey: "name")
    }
    
    private func storeBudgetInUserDefaults() {
        UserDefaults.standard.set(try? JSONEncoder().encode(budget), forKey: "budget")
    }
    
    private func restoreFromUserDefaults() {
        if let jsonData = UserDefaults.standard.data(forKey: "name"),
           let decodedname = try? JSONDecoder().decode(String.self, from: jsonData) {
            name = decodedname
        }
        if let jsonData = UserDefaults.standard.data(forKey: "budget"),
           let decodedbudget = try? JSONDecoder().decode(String.self, from: jsonData) {
            budget = decodedbudget
        }

    }
    
    init() {
        restoreFromUserDefaults()
    }
    
}
