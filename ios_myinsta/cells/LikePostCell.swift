

import SwiftUI
import SDWebImageSwiftUI

struct LikePostCell: View {
    @State private var showingAlert = false
    var uid: String
    var viewModel: LikesViewModel
    @State var post: Post
    
    var body: some View {
        VStack(spacing: 0){
            HStack{
                VStack{
                    if !post.imgUser!.isEmpty {
                        WebImage(url: URL(string: post.imgUser!))
                            .resizable().clipShape(Circle())
                            .frame(width: 46, height: 46)
                            .padding(.all, 2)
                    } else {
                        Image("ic_person").resizable().clipShape(Circle())
                            .frame(width: 46, height: 46)
                            .padding(.all, 2)
                    }
                }.overlay(RoundedRectangle(cornerRadius: 25)
                    .stroke(Utils.color2, lineWidth: 2))
                VStack(alignment: .leading, spacing: 3) {
                    Text(post.displayName!)
                        .foregroundColor(.black)
                        .font(.system(size: 17))
                        .fontWeight(.medium)
                    Text(post.time!)
                        .foregroundColor(.gray)
                        .font(.system(size: 15))
                }
                Spacer()
                Button(action: {
                    self.showingAlert.toggle()
                }, label: {
                    if uid == post.uid {
                        Image("ic_more").font(.system(size: 15)).foregroundColor(.black)
                    }
                })
                .buttonStyle(PlainButtonStyle())
                .alert(isPresented: $showingAlert){
                    let title = "Delete"
                    let message = "Do you want to delete this post?"
                    return Alert(title: Text(title), message: Text(message), primaryButton: .destructive(Text("Confirm"), action: {
                        //some action
                        viewModel.apiRemovePost(uid: uid, post: post)
                    }), secondaryButton: .cancel())
                }
            }.padding(.top, 15)
                .padding(.leading, 15)
                .padding(.trailing, 15)
            
            WebImage(url: URL(string: post.imgPost!))
                .resizable().scaledToFit()
                .padding(.top, 15)
            HStack(spacing: 10) {
                Button(action: {
                    if post.isLiked! {
                        post.isLiked = false
                    } else {
                        post.isLiked = true
                    }
                    viewModel.apiLikePost(uid: uid, post: post)
                }, label: {
                    if post.isLiked! {
                        Image("ic_like_on").resizable().frame(width: 25, height: 25)
                            .foregroundColor(.red)
                    } else {
                        Image("ic_like_off").resizable().frame(width: 25, height: 25)
                            .foregroundColor(.black)
                    }
                })
                Button(action: {
                    
                }, label: {
                    Image("ic_share").resizable().frame(width: 25, height: 25).foregroundColor(.black)
                })
                Spacer()
            }.padding(.top, 15).padding(.leading, 15).padding(.trailing, 15)
            HStack(spacing: 0){
                Text(post.caption!)
                    .foregroundColor(.black)
                    .font(.system(size: 16))
                Spacer()
            }.padding(.all, 15)
        }
    }
}

struct LikePostCell_Previews: PreviewProvider {
    static var previews: some View {
        LikePostCell(uid: "uid", viewModel: LikesViewModel(), post: Post(caption: "symbolic", imgPost: Utils.image1))
    }
}
