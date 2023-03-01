//
//  UserCell.swift
//  ios_myinsta
//
//  Created by Bekhruz Hakmirzaev on 16/02/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct UserCell: View {
    var user: User
    var body: some View {
        HStack(spacing: 0){
            VStack{
                if !user.imgUser!.isEmpty {
                    WebImage(url: URL(string: user.imgUser!))
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: 45, height: 45)
                        .padding(.all, 2)
                } else {
                    Image("ic_person")
                        .resizable()
                        .clipShape(Circle())
                        .frame(width: 45, height: 45)
                        .padding(.all, 2)
                }
            }.overlay(RoundedRectangle(cornerRadius: 24).stroke(Utils.color2, lineWidth: 2))
            VStack(alignment: .leading, spacing: 0){
                Text(user.displayName!).foregroundColor(.black)
                    .font(.system(size: 17))
                    .fontWeight(.medium)
                Text(user.email!).foregroundColor(.gray)
                    .font(.system(size: 15))
            }.padding(.leading, 15)
            Spacer()
            Button(action: {
                
            }, label: {
                Text("Following")
                    .font(.system(size: 15))
                    .foregroundColor(.black.opacity(0.5))
                    .frame(width: 90, height: 30)
                    .overlay(RoundedRectangle(cornerRadius: 5).stroke(.gray, lineWidth: 1))
            })
        }.padding(.all, 20)
    }
}

struct UserCell_Previews: PreviewProvider {
    static var previews: some View {
        UserCell(user: User(uid: "1", email: "hakmirzaevb@gmail.com", displayName: "Bekhruzjon"))
    }
}
