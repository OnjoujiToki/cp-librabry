//
//  NotebookPageView.swift
//  cp-librabry
//
//  Created by Siyuan He on 4/28/23.
//

import SwiftUI

struct NotebookPageView: View {
    @State private var title: String = ""
    @State private var content: String = ""
    @State private var date = Date()
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                TextField("Title", text: $title)
                    .font(.system(size: 24, weight: .bold))
                Spacer()
                Text(dateFormatter.string(from: date))
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
            .padding(.horizontal)
            .padding(.top)

            Divider()
                .padding(.horizontal)

            ScrollView {
                TextField("Take note here...", text: $content)
                    .font(.system(size: 18))
                    .padding(.horizontal)
            }
        }
        .background(Color(.systemBackground))
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct NotebookPageView_Previews: PreviewProvider {
    static var previews: some View {
        NotebookPageView()
    }
}

