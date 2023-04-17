import SwiftUI
import FirebaseAuth

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isRegistering = false
    @EnvironmentObject var userManager: UserManager
    
    var body: some View {
        VStack {
            if userManager.isLoggedIn {
               
                    VStack {
                        Text("Welcome!")
                            .font(.largeTitle)
                        
                        NavigationLink(destination: CodeforcesProfileView()) {
                            Text("Go to Codeforces Profile")
                                .foregroundColor(.white)
                                .padding(.horizontal, 30)
                                .padding(.vertical, 12)
                                .background(Color.blue)
                                .cornerRadius(8)
                        }
                        
                        Button(action: {
                            userManager.logout()
                        }) {
                            Text("Logout")
                                .foregroundColor(.white)
                                .padding(.horizontal, 40)
                                .padding(.vertical, 12)
                                .background(Color.red)
                                .cornerRadius(8)
                        }
                        .padding()
                    }
                } else {
                    TextField("Email", text: $email)
                        .padding()
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                    SecureField("Password", text: $password)
                        .padding()
                        .textContentType(.oneTimeCode)
                    HStack {
                        Button(action: {
                            userManager.login(email: email, password: password)
                        }) {
                            Text("Login")
                        }
                        Button(action: {
                            isRegistering.toggle()
                        }) {
                            Text("Register")
                        }
                        .sheet(isPresented: $isRegistering) {
                            RegisterView(isRegistering: $isRegistering)
                                .environmentObject(userManager)
                        }
                    }
                }
        }
        .padding()
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(UserManager())
    }
}
