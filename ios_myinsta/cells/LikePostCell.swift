

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
                    Image("ic_person").resizable().clipShape(Circle())
                        .frame(width: 46, height: 46)
                        .padding(.all, 2)
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
                    
                }, label: {
                    Image("ic_more").font(.system(size: 15)).foregroundColor(.black)
                })
            }.padding(.top, 15)
                .padding(.leading, 15)
                .padding(.trailing, 15)
            
            WebImage(url: URL(string: post.imgPost!))
                .resizable().scaledToFit()
                .padding(.top, 15)
            HStack(spacing: 10) {
                Button(action: {
                    
                }, label: {
                    Image("ic_like_off").resizable().frame(width: 25, height: 25)
                        .foregroundColor(.black)
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
