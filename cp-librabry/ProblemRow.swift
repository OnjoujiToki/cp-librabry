//
//  ProblemRow.swift
//  cp-librabry
//
//  Created by OnjoujiToki on 4/18/23.
//

import SwiftUI

struct ProblemRow: View {
    let problem: Problem
    var color: Color
    var body: some View {
        VStack(alignment: .leading) {
            Text(problem.id + " " + problem.name)
                .foregroundColor(color)
            Text("Difficulty: \(problem.difficulty ?? 0)")
            
            Text("Tags: \(problem.tags.joined(separator: ", "))")
        }
    }
}

/*
struct ProblemRow_Previews: PreviewProvider {
    static var previews: some View {
        ProblemRow(problem: Problem(contestId: 1, index: "A", name: "Example Problem", difficulty: 1000, tags: ["example", "test"]))
    }
}*/
