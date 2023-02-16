//
//  MyPostCell.swift
//  ios_myinsta
//
//  Created by Bekhruz Hakmirzaev on 17/02/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct MyPostCell: View {
    var post: Post
    var length: CGFloat
    var body: some View {
        VStack{
            WebImage(url: URL(string: post.imgUrl!))
                .resizable().frame(width: length, height: length)
                .scaledToFit()
            Text("Make a symbolic breakpoint at")
                .foregroundColor(.black)
                .font(.system(size: 16))
                .padding(.top, 10).padding(.bottom, 10)
        }
    }
}

struct MyPostCell_Previews: PreviewProvider {
    static var previews: some View {
        MyPostCell(post: Post(title: "Bekhruzjon", content: "February 16, 2022", imgUrl: Utils.image1), length: UIScreen.width)
    }
}
