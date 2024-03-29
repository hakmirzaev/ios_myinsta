//
//  MyPostCell.swift
//  ios_myinsta
//
//  Created by Bekhruz Hakmirzaev on 17/02/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct MyPostCell: View {
    var uid: String
    var viewModel: ProfileViewModel
    @State private var showingAlert = false
    var post: Post
    var length: CGFloat
    var body: some View {
        VStack{
            VStack(alignment: .leading, spacing: 0) {
                WebImage(url: URL(string: post.imgPost!))
                    .resizable().frame(width: length, height: length)
                    .scaledToFit()
                    .onLongPressGesture {
                        self.showingAlert = true
                    }
                    .alert(isPresented: $showingAlert) {
                        let title = "Delete"
                        let message = "Do you want to delete this post?"
                        return Alert(title: Text(title), message: Text(message), primaryButton: .destructive(Text("Confirm"), action: {
                            // Some action
                            viewModel.apiRemovePost(uid: uid, post: post)
                        }), secondaryButton: .cancel())
                    }
                Text(post.caption!)
                    .foregroundColor(.black)
                    .font(.system(size: 16))
                    .padding(.top, 10)
                    .padding(.bottom, 10)
            }
        }
    }
}

struct MyPostCell_Previews: PreviewProvider {
    static var previews: some View {
        MyPostCell(uid: "uid", viewModel: ProfileViewModel(),post: Post(caption: "bekhruzjon", imgPost: Utils.image2),length: UIScreen.width)
    }
}
