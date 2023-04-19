import SwiftUI

struct recommendationView: View {
    @EnvironmentObject var userManager: UserManager
    @State private var userRating: Int = 0
    @State private var easyProblems: [Problem] = []
    @State private var mediumProblems: [Problem] = []
    @State private var hardProblems: [Problem] = []

    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Easy")) {
                    ForEach(easyProblems) { problem in
                        ProblemRow(problem: problem, color: getColorForDifficulty(problem.difficulty ?? 0))
                    }
                }
                
                Section(header: Text("Medium")) {
                    ForEach(mediumProblems) { problem in
                        ProblemRow(problem: problem, color: getColorForDifficulty(problem.difficulty ?? 0))
                    }

                }
                
                Section(header: Text("Hard")) {
                    ForEach(hardProblems) { problem in
                        ProblemRow(problem: problem, color: getColorForDifficulty(problem.difficulty ?? 0))
                    }
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Recommendations")
            .onAppear {
                userManager.fetchCodeforcesHandle { handle in
                    if let handle = handle {
                        userManager.fetchCodeforcesProfile(handle: handle) { result in
                            switch result {
                            case .success(let data):
                                if let resultArray = data["result"] as? [[String: Any]], let userProfile = resultArray.first {
                                    userRating = userProfile["rating"] as? Int ?? 0
                                    fetchProblems()
                                }
                            case .failure(let error):
                                print("Error fetching user rating: \(error.localizedDescription)")
                            }
                        }
                    }
                }
            }

        }
    }
    
    private func fetchProblems() {
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
                        let allProblems = decodedResponse.result.problems
                        print(allProblems.count)
                        print(userRating)
                        easyProblems = Array(allProblems.filter { problem in
                            guard let difficulty = problem.difficulty else { return false }
                            return difficulty >= userRating - 300 && difficulty <= userRating - 200
                        }
                        .shuffled()
                        .prefix(3))
                        
                        mediumProblems = Array(allProblems.filter { problem in
                            guard let difficulty = problem.difficulty else { return false }
                            return difficulty >= userRating - 100 && difficulty <= userRating + 100
                        }
                        .shuffled()
                        .prefix(3))
                        
                        hardProblems = Array(allProblems.filter { problem in
                            guard let difficulty = problem.difficulty else { return false }
                            return difficulty >= userRating + 200 && difficulty <= userRating + 300
                        }
                        .shuffled()
                        .prefix(3))
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }
        
        task.resume()
    }


}




