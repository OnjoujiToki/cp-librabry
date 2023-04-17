import SwiftUI
import FirebaseFirestore
import FirebaseAuth

struct ToDoView: View {
    @State private var favoriteProblems: [Problem] = []
    @State private var allProblems: [Problem] = []

    var body: some View {
        NavigationView {
            List {
                ForEach(favoriteProblems) { problem in
                    VStack(alignment: .leading) {
                        Text(problem.id + " " + problem.name)
                            .foregroundColor(getColorForDifficulty(problem.difficulty ?? 0))
                        Text("Difficulty: \(problem.difficulty ?? 0)")
                        Text("Tags: \(problem.tags.joined(separator: ", "))")
                    }
                }
                .onDelete(perform: deleteFavoriteProblem)
            }
            .navigationBarTitle("To-Do List")
            .onAppear {
                fetchFavoriteProblems()
            }

        }
    }

    func loadProblems() {
        let urlString = "https://codeforces.com/api/problemset.problems"

        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode(ProblemSetProblemsResponse.self, from: data)
                    DispatchQueue.main.async {
                        allProblems = decodedResponse.result.problems
                        fetchFavoriteProblems()
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }

        task.resume()
    }

    func fetchFavoriteProblems() {
        guard let uid = fetchCurrentUserUID() else {
            print("Error: User not signed in.")
            return
        }
        
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(uid)
        
        userRef.getDocument { document, error in
            if let error = error {
                print("Error fetching favorite problems: \(error)")
            } else {
                if let document = document, document.exists {
                    if let favoriteProblemIds = document.get("favoriteProblems") as? [String] {
                        loadFavoriteProblems(favoriteProblemIds: favoriteProblemIds)
                    } else {
                        print("Error: Favorite problems not found.")
                    }
                } else {
                    print("Error: Document does not exist.")
                }
            }
        }
    }
    func loadFavoriteProblems(favoriteProblemIds: [String]) {
        let urlString = "https://codeforces.com/api/problemset.problems"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decodedResponse = try JSONDecoder().decode(ProblemSetProblemsResponse.self, from: data)
                    DispatchQueue.main.async {
                        allProblems = decodedResponse.result.problems
                        favoriteProblems = allProblems.filter { favoriteProblemIds.contains($0.id) }
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }

        task.resume()
    }

    func deleteFavoriteProblem(at offsets: IndexSet) {
        guard let uid = fetchCurrentUserUID() else {
            print("Error: User not signed in.")
            return
        }
        
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(uid)
        
        for index in offsets {
            let problemId = favoriteProblems[index].id
            userRef.updateData([
                "favoriteProblems": FieldValue.arrayRemove([problemId])
            ]) { error in
                if let error = error {
                    print("Error removing problem from favorites: \(error)")
                } else {
                    favoriteProblems.remove(at: index)
                }
            }
        }
    }

    
    func fetchCurrentUserUID() -> String? {
        if let user = Auth.auth().currentUser {
            return user.uid
        }
        return nil
    }
}
