//
//  AboutView.swift
//  cp-librabry
//
//  Created by Siyuan He on 4/27/23.
//

import SwiftUI

struct AboutView: View {
    var body: some View {
        ZStack {
            Color(hex: "#1abc9c")
                .edgesIgnoringSafeArea(.all)
            VStack{
                VStack {
                    Image("profile2")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100.0, height: 100.0)
                        .clipShape(Circle())
                        .overlay(
                            Circle().stroke(Color(.systemGray6), lineWidth: 0.5)
                    )
                    Text("OnjoujiToki")
                        .font(Font.custom("Pacifico-Regular", size: 25))
                        .bold()
                        .foregroundColor(.white)
                        .padding(.top, -10)
                        .padding(.bottom, 1)
                    InfoAboutView(text: "GitHub Profile", imageName: "person.crop.square.filled.and.at.rectangle", infoUrl: "https://github.com/OnjoujiToki")
                    InfoEmailView(imageName: "envelope.fill", email: "zhang.zhihao1@northeastern.edu")
                }
                .padding(.bottom,40)
                Divider()
                VStack {
                    Image("profile1")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100.0, height: 100.0)
                        .clipShape(Circle())
                        .overlay(
                            Circle().stroke(Color(.systemGray6), lineWidth: 0.5)
                    )
                    Text("Siyuan He")
                        .font(Font.custom("Pacifico-Regular", size: 25))
                        .bold()
                        .foregroundColor(.white)
                        .padding(.top, -10)
                        .padding(.bottom, 1)
                    InfoAboutView(text: "GitHub Profile", imageName: "person.crop.square.filled.and.at.rectangle", infoUrl: "https://github.com/siyuanhe98")
                    InfoEmailView(imageName: "envelope.fill", email: "he.siyua@northeastern.edu")
                }
                .padding(.top, 40)
            }
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}

//struct InfoEmailView: View {
//    let imageName: String
//    let email: String
//    var body: some View {
//        RoundedRectangle(cornerRadius: 25)
//            .fill(Color.white)
//            .frame(height: 50)
//            .overlay(HStack {
//                Image(systemName: imageName)
//                    .foregroundColor(Color(hex: "#2c3e50"))
//                Link("Email me", destination: URL(string: "mailto:\(email)")!)
//                //This line below is required if you want the app to display correctly in dark mode.
//                    //In dark mode all Text is automatically rendered as white.
//                    //So we've created a custom color in the assets folder called Infor Color and used it here.
//                    .foregroundColor(Color(hex: "#7f8c8d"))
//            }
//            .padding(.leading, -37)
//            )
//            .padding(.horizontal, 90)
//    }
//}
//
//struct InfoAboutView: View {
//    let text: String
//    let imageName: String
//    let infoUrl: String
//    var body: some View {
//        RoundedRectangle(cornerRadius: 25)
//            .fill(Color.white)
//            .frame(height: 50)
//            .overlay(HStack {
//                Image(systemName: imageName)
//                    .foregroundColor(Color(hex: "#2c3e50"))
//                Text(text)
//                    .onTapGesture {
//                        UIApplication.shared.open(URL(string: infoUrl)!)
//                    }
//                //This line below is required if you want the app to display correctly in dark mode.
//                    //In dark mode all Text is automatically rendered as white.
//                    //So we've created a custom color in the assets folder called Infor Color and used it here.
//                    .foregroundColor(Color(hex: "#7f8c8d"))
//            })
//            .padding(.horizontal, 90)
//    }
//}
