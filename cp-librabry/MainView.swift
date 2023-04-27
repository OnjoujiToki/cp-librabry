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
    @State private var showingConfirmationAlert = false
    
    var body: some View {
        if !userManager.isLoggedIn{
            LoginView()
        } else {
            TabView(selection: $selection) {
                ProblemListView()
                    .tabItem {
                        Label("Problems", systemImage: "list.bullet")
                    }
                    .tag(0)
                
                ContestView()
                    .tabItem {
                        Label("Contests", systemImage: "highlighter")
                    }
                    .tag(1)
                
                ToDoView()
                    .tabItem {
                        Label("To-Do", systemImage: "bookmark")
                    }
                    .tag(2)
                recommendationView()
                    .tabItem {
                        Label("For You", systemImage: "lasso.and.sparkles")
                    }
                    .tag(3)
                NavigationView {
                    CodeforcesProfileView()
                        .navigationBarItems(trailing:
                                                Button(action: {
                            showingConfirmationAlert = true
                        }) {
                            Image(systemName: "rectangle.portrait.and.arrow.right.fill")
                                .resizable()
                                .frame(width: 25, height: 25)
                        }
                        )
                        .accentColor(Color(hex: "#ecf0f1"))
                        .alert(isPresented: $showingConfirmationAlert) {
                            Alert(title: Text("Are you sure you want to logout?"),
                                  primaryButton: .destructive(Text("Logout")) {
                                userManager.logout()
                            },
                                  secondaryButton: .cancel())
                        }
                }
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
                .tag(4)
                
                AboutView()
                    .tabItem {
                        Label("About", systemImage: "person.circle")
                    }
                    .tag(5)
            }
            .accentColor(.white)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(UserManager())
    }
}
