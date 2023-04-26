import SwiftUI
import FirebaseFirestore

struct CodeforcesProfileView: View {
    @State private var handle = ""
    @State private var profileData: [String: Any]?
    @State private var errorMessage = ""
    @EnvironmentObject var userManager: UserManager

    var body: some View {
        ZStack {
            Color(hex: "#1abc9c")
                .edgesIgnoringSafeArea(.all)
            VStack {
                if let profileData = profileData {
                    Text("\(profileData["handle"] as? String ?? "")")
                        .font(Font.custom("Pacifico-Regular", size: 40))
                        .bold()
                        .foregroundColor(.white)
                        .padding(.bottom, 5)
                    AsyncImage(url: URL(string: profileData["avatar"] as! String)) { phase in
                        switch phase {
                        case .empty:
                            // Placeholder while the image is being downloaded
                            ProgressView()
                        case .success(let image):
                            // The loaded image
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 150.0, height: 150.0)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.white, lineWidth: 2)
                                    
                                )
                                .padding(.top, -225)
                        case .failure:
                            // Display an error message or a placeholder image in case of failure
                            Text("Failed to load logo image")
                        @unknown default:
                            fatalError()
                        }
                    }
                }
                TextField("Codeforces Handle", text: $handle)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .disableAutocorrection(true)
                    .foregroundColor(Color(hex: "#bdc3c7"))
                Divider().padding(.top, -5)
                Button(action: {
                    updateUserHandle()
                }) {
                    Text("Update Handle")
                        .frame(maxWidth: 150)
                        .font(Font.custom("BrunoAceSC-Regular", size: 15))
                }.tint(Color(hex: "#16a085"))
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .padding(.top, 20)
                
                if let profileData = profileData {
                    VStack{
                        InfoView(text1:"Contribution: ", text2: "\(profileData["problemSolved"] as? Int ?? 0)", imageName: "number.circle.fill")
                        InfoView(text1:"Current Rating: ", text2: "\(profileData["currentRating"] as? Int ?? 0)", imageName: "star.leadinghalf.filled")
                        InfoView(text1:"Max Rating: ", text2: "\(profileData["maxRating"] as? Int ?? 0)", imageName: "star.circle.fill")
                    }
                    .padding(.top, 20)
                }
//                if !errorMessage.isEmpty {
//                    Text(errorMessage)
//                        .foregroundColor(.red)
//                        .padding(.top, 20)
//                }
            }
            .padding()
            .onAppear {
                fetchUserHandle()
            }
        }
    }
    private func fetchUserHandle() {
        userManager.fetchCodeforcesHandle { fetchedHandle in
            if let fetchedHandle = fetchedHandle {
                handle = fetchedHandle
                fetchProfileData(for: fetchedHandle)
            }
        }
    }
    
    private func updateUserHandle() {
        print("Updating handle to: \(handle)")
        userManager.updateCodeforcesHandle(handle: handle) { success in
            if success {
                fetchProfileData(for: handle)
            } else {
                errorMessage = "Failed to update Codeforces handle"
            }
        }
    }
    
    private func fetchProfileData(for handle: String) {
        print("Fetching profile data for handle: \(handle)")
        userManager.fetchCodeforcesProfile(handle: handle) { result in
            switch result {
            case .success(let data):
                if let resultArray = data["result"] as? [[String: Any]], let userProfile = resultArray.first {
                    let currentRating = userProfile["rating"] as? Int ?? 0
                    let maxRating = userProfile["maxRating"] as? Int ?? 0
                    let problemSolved = userProfile["contribution"] as? Int ?? 0
                    let avatar = userProfile["avatar"] as? String ?? "https://msrealtors.org/wp-content/uploads/2018/11/no-user-image.gif"
                    let handle = userProfile["handle"] as? String ?? ""
                    profileData = [
                        "currentRating": currentRating,
                        "maxRating": maxRating,
                        "problemSolved": problemSolved,
                        "avatar": avatar,
                        "handle": handle
                    ]
                    errorMessage = ""
                } else {
                    errorMessage = "Failed to fetch Codeforces profile data"
                }
            case .failure(let error):
                errorMessage = error.localizedDescription
            }
        }
    }
}

struct CodeforcesProfileView_Previews: PreviewProvider {
    static var previews: some View {
        CodeforcesProfileView().environmentObject(UserManager())
    }
}
