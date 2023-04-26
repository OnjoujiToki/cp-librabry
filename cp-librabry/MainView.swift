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
                NavigationView {
                    CodeforcesProfileView()
                        .navigationBarItems(trailing:
                                            Button(action: {
                                                showingConfirmationAlert = true
                                            }) {
                                                Text("Logout")
                                                    .fontWeight(.semibold)
                                                    .foregroundColor(Color(hex: "#7f8c8d"))
                                                    .frame(maxWidth: 100)
                                                    .font(Font.custom("BrunoAceSC-Regular", size: 12))
                                            }
                                            .buttonStyle(.borderedProminent)
                                            .controlSize(.large)
                                            .clipShape(RoundedRectangle(cornerRadius: 15))
                                            .padding(.trailing, 5)
                                            .padding(.top, 10)
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
            .accentColor(.white)
            
//            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(UserManager())
    }
}

//extension UINavigationController {
//    override open func viewDidLoad() {
//        super.viewDidLoad()
//        let appearance = UINavigationBarAppearance()
//        appearance.configureWithOpaqueBackground()
//        appearance.backgroundColor = UIColor(Color(hex: "#16a085")) // Set your desired color here
//        navigationBar.standardAppearance = appearance
//        navigationBar.scrollEdgeAppearance = appearance
//    }
//}
