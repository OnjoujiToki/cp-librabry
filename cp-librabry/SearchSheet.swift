import SwiftUI

struct SearchSheet: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var minDifficulty: Int
    @Binding var maxDifficulty: Int
    @Binding var searchTags: Set<String>
    let onSearch: () -> Void
    let availableTags: [String] = ["dp", "graphs", "math", "greedy", "implementation", "brute force", "2-sat","binary search","bitmasks","chinese remainder theorm","combinatorics","constructive algorithms","dfs and similiar","divide and conquer", "dsu","expression parsing","fft","flows","games","graph matchings","hashing","interactive","matrices","meet-in-the-middle","number theory","probabilities","schedules","shortest paths","string suffix structures","strings", "data structures", "sortings", "ternary search", "trees", "two pointers"]

    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    Text("Difficulty Range")
                        .font(.headline)
                    Picker("Minimum Difficulty", selection: $minDifficulty) {
                        ForEach(Array(stride(from: 1000, to: 3000, by: 100)), id: \.self) { difficulty in
                            Text("\(difficulty)").tag(difficulty)
                        }
                    }
                    Picker("Maximum Difficulty", selection: $maxDifficulty) {
                        ForEach(Array(stride(from: 1000, to: 3000, by: 100)), id: \.self) { difficulty in
                            Text("\(difficulty)").tag(difficulty)
                        }
                    }
                }
                .padding(.top)

                VStack(alignment: .leading) {
                    Text("Tags")
                        .font(.headline)

                    let columns = [GridItem(.adaptive(minimum: 150), spacing: 16)]
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(availableTags, id: \.self) { tag in
                                Button(action: {
                                    if searchTags.contains(tag) {
                                        searchTags.remove(tag)
                                    } else {
                                        searchTags.insert(tag)
                                    }
                                }) {
                                    HStack {
                                        Text(tag)
                                        Spacer()
                                        if searchTags.contains(tag) {
                                            Image(systemName: "checkmark")
                                        }
                                    }
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                                }
                            }
                        }
                    }
                }
                .padding(.top)

                Spacer()
            }
            .padding()
            .navigationBarTitle("Search Filters")
            .navigationBarItems(trailing: Button("Search", action: {
                            onSearch()
                            presentationMode.wrappedValue.dismiss()
                        }))
        }
    }
}
