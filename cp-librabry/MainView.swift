//
//  cp_librabryApp.swift
//  cp-librabry
//
//  Created by OnjoujiToki on 4/13/23.
//

import SwiftUI
struct MainView: View {
    @EnvironmentObject var userManager: UserManager
    @State private var selection = 0
    
    var body: some View {
        if !userManager.isLoggedIn{
            LoginView()
        } else {
            TabView(selection: $selection) {
                NavigationView {
                    CodeforcesProfileView()
                        .navigationBarItems(trailing: Button("Logout", action: userManager.logout))
                }
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
                .tag(0)
                
                ProblemListView()
                    .tabItem {
                        Label("Problems", systemImage: "list.bullet")
                    }
                    .tag(1)
                
                ContestView()
                    .tabItem {
                        Label("Contests", systemImage: "calendar")
                    }
                    .tag(2)
                
                ToDoView()
                    .tabItem {
                        Label("To-Do", systemImage: "checkmark.circle")
                    }
                    .tag(3)
                recommendationView()
                    .tabItem {
                        Label("Recommendations", systemImage: "star")
                    }
                    .tag(4)
            }
        }
    }
}
