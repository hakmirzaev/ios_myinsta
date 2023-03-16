
import SwiftUI
import SDWebImageSwiftUI

struct OthersPostCell: View {
    var uid: String
    var viewModel: OthersProfileViewModel
    @State private var showingAlert = false
    var post: Post
    var length: CGFloat
    var body: some View {
        VStack{
            VStack(alignment: .leading, spacing: 0) {
                WebImage(url: URL(string: post.imgPost!))
                    .resizable().frame(width: length, height: length)
                    .scaledToFit()
                    
                Text(post.caption!)
                    .foregroundColor(.black)
                    .font(.system(size: 16))
                    .padding(.top, 10)
                    .padding(.bottom, 10)
            }
        }
    }
}

struct OthersPostCell_Previews: PreviewProvider {
    static var previews: some View {
        OthersPostCell(uid: "uid", viewModel: OthersProfileViewModel(),post: Post(caption: "bekhruzjon", imgPost: Utils.image2),length: UIScreen.width)
    }
}

