//
//  ProfileView.swift
//  Expenses (iOS)
//
//  Created by Iris Fu on 5/25/21.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var profile: Profile
    
    var body: some View {
        VStack {
            Text("Profile")
                .font(.title)
            Form {
                Section(header: Text("Name").themetext()) {
                    TextField("Your name", text: $profile.name)
                }
                Section(header: Text("Default Budget").themetext()) {
                    TextField("Amount", text: $profile.budget)
                        .keyboardType(.decimalPad)
                }
            }
        }
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(Profile())
    }
}

