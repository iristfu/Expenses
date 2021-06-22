//
//  ContentView.swift
//  Shared
//
//  Created by Iris Fu on 5/24/21.
//

import SwiftUI
import CoreData

struct ContentView: View {

    @EnvironmentObject var profile: Profile
    @Environment(\.managedObjectContext) var viewContext
    
    @State private var selection: Tab = .home
    
    enum Tab {
        case home
        case trends
        case profile
    }
    
    // referneced https://www.appcoda.com/swiftui-tabview/
    var body: some View {
        TabView(selection: $selection) {
            HomeView(sortBy: NSSortDescriptor(keyPath: \Expense.date_, ascending: false))
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(Tab.home)
                .gesture(tabSwipe())
                
            VisualizeView()
                .tabItem {
                    Label("Trends", systemImage: "chart.bar.xaxis")
                }
                .tag(Tab.trends)
                .highPriorityGesture(tabSwipe())

            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
                .tag(Tab.profile)
                .gesture(tabSwipe())
        }
        .onAppear() {
            UITabBar.appearance().barTintColor = .white
        }
        .accentColor(moneyGreen)
        .animation(.easeInOut)
        .transition(.slide)
    }
        
    @GestureState private var gesturePanOffset: CGSize = CGSize.zero
    
    private func tabSwipe() -> some Gesture {
        DragGesture()
            .updating($gesturePanOffset) { latestDragGestureValue, gesturePanOffset, _ in
                gesturePanOffset = latestDragGestureValue.translation
            }
            .onEnded { finalDragGestureValue in
                let translation: CGFloat = finalDragGestureValue.translation.width
                if translation > Constants.minDragTranslationForSwipe && selection != .home {
                    if selection == .profile {
                        selection = .trends
                    } else {
                        selection = .home
                    }
                } else if translation < -Constants.minDragTranslationForSwipe && selection != Tab.profile {
                    if selection == .home {
                        selection = .trends
                    } else {
                        selection = .profile
                    }
                }
            }
    }
    
}

private struct Constants {
    static var numTabs = 3
    static var minDragTranslationForSwipe: CGFloat = 50
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .environmentObject(Profile())
    }
}


