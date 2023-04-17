import SwiftUI
import FirebaseFirestore

struct CodeforcesProfileView: View {
    @State private var handle = ""
    @State private var profileData: [String: Any]?
    @State private var errorMessage = ""
    @EnvironmentObject var userManager: UserManager

    var body: some View {
        VStack {
            TextField("Codeforces Handle", text: $handle)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .autocapitalization(.none)
                .padding(.bottom, 10)
            
            Button(action: {
                updateUserHandle()
            }) {
                Text("Update Handle")
                    .foregroundColor(.white)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 12)
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            
            if let profileData = profileData {
                VStack(alignment: .leading) {
                    Text("Contribution: \(profileData["problemSolved"] as? Int ?? 0)")
                    Text("Current Rating: \(profileData["currentRating"] as? Int ?? 0)")
                    Text("Max Rating: \(profileData["maxRating"] as? Int ?? 0)")
                }
                .padding(.top, 20)
            }
            
            if !errorMessage.isEmpty {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding(.top, 20)
            }
        }
        .padding()
        .onAppear {
                    fetchUserHandle()
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
                    
                    profileData = [
                        "currentRating": currentRating,
                        "maxRating": maxRating,
                        "problemSolved": problemSolved
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
