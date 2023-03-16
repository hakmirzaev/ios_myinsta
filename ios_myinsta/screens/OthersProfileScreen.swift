
import SwiftUI
import SDWebImageSwiftUI

struct OthersProfileScreen: View {
    @ObservedObject var viewModel = OthersProfileViewModel()
    @EnvironmentObject var session: SessionStore
    @State var action = false
    @State var isImagePickerDisplay = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State var showingAlert = false
    var uid: String
    var user: User
    
    @State var level = 2
    @State var columns: [GridItem] = Array(repeating: GridItem(.flexible(minimum: UIScreen.width/2 - 15), spacing: 10), count: 2)
    
    func postSize() -> CGFloat{
        if level ==  1 {
            return UIScreen.width/CGFloat(level) - 20
        }
        return UIScreen.width/CGFloat(level) - 15
    }
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack(spacing: 0){
                    ZStack{
                        VStack{
                            if !viewModel.imgUser.isEmpty {
                                WebImage(url: URL(string: viewModel.imgUser)).resizable().clipShape(Circle())
                                    .frame(width: 70, height: 70)
                                    .padding(.all, 2)
                            } else {
                                Image("ic_person").resizable().clipShape(Circle())
                                    .frame(width: 70, height: 70)
                                    .padding(.all, 2)
                            }
                        }.overlay(RoundedRectangle(cornerRadius: 37).stroke(Utils.color2, lineWidth: 2))
                    }
                    Text(viewModel.displayName)
                        .foregroundColor(.black)
                        .font(.system(size: 17))
                        .fontWeight(.medium)
                        .padding(.top, 15)
                    Text(viewModel.email)
                        .foregroundColor(.gray)
                        .font(.system(size: 15))
                        .padding(.top, 3)
                    
                    Button(action: {
                        if user.isFollowed {
                            viewModel.apiUnFollowUser(uid: (session.session?.uid)!, to: user)
                        } else {
                            viewModel.apiFollowUser(uid: (session.session?.uid)!, to: user)
                        }
                    }, label: {
                        if user.isFollowed {
                            Text("Following")
                                .font(.system(size: 15))
                                .foregroundColor(.black.opacity(0.5))
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity,maxHeight: 25)
                                .overlay(RoundedRectangle(cornerRadius: 12).stroke(.gray, lineWidth: 2))
                                .padding()
                        } else {
                            Text("Follow")
                                .font(.system(size: 15))
                                .foregroundColor(.white)
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity,maxHeight: 25)
                                .overlay(RoundedRectangle(cornerRadius: 12).stroke(.gray, lineWidth: 2))
                                .background(.blue).cornerRadius(12)
                                .padding()
                        }
                    })
                    
                    //post, following, followers count
                    HStack{
                        VStack{
                            Text("\(viewModel.items.count)")
                                .foregroundColor(.black)
                                .font(.system(size: 17))
                                .fontWeight(.medium)
                            Text("Posts").foregroundColor(.gray)
                                .font(.system(size: 15))
                        }.frame(maxWidth: UIScreen.width/3, maxHeight: 60)
                        VStack{}.frame(maxWidth: 1, maxHeight: 25)
                            .background(Color.gray.opacity(0.5))
                        VStack{
                            Text("\(viewModel.followers.count)")
                                .foregroundColor(.black)
                                .font(.system(size: 17))
                                .fontWeight(.medium)
                            Text("Followers")
                                .foregroundColor(.gray)
                                .font(.system(size: 15))
                        }.frame(maxWidth: UIScreen.width/3, maxHeight: 60)
                        VStack{}.frame(maxWidth: 1, maxHeight: 25)
                            .background(Color.gray.opacity(0.5))
                        VStack{
                            Text("\(viewModel.following.count)")
                                .foregroundColor(.black)
                                .font(.system(size: 17))
                                .fontWeight(.medium)
                            Text("Following").foregroundColor(.gray)
                                .font(.system(size: 15))
                        }.frame(maxWidth: UIScreen.width/3, maxHeight: 60)
                    }.padding(.top, 10).frame(height: 60)
                    
                    HStack{
                        Button(action: {
                            level = 1
                            columns = Array(repeating: GridItem(.flexible(minimum: UIScreen.width/2 - 15)), count: 1)
                        }, label: {
                            Image("ic_list").resizable().foregroundColor(.black.opacity(0.5))
                                .frame(width: 30, height: 30)
                        }).frame(maxWidth: UIScreen.width)
                        
                        Button(action: {
                            level = 2
                            columns = Array(repeating: GridItem(.flexible(minimum: UIScreen.width/2 - 15)), count: 2)
                        }, label: {
                            Image("ic_grid").resizable().foregroundColor(.black.opacity(0.5))
                                .frame(width: 30, height: 30)
                        }).frame(maxWidth: UIScreen.width)
                    }.padding(.top, 10).padding(.bottom, 10)
                    
                    //my posts
                    ScrollView{
                        LazyVGrid(columns: columns, spacing: 10){
                            ForEach(viewModel.items, id: \.self){ item in
                                OthersPostCell(uid:uid,viewModel: viewModel,post: item, length: postSize())
                            }
                        }
                    }.padding(.top, 10)
                }.padding(.all, 20)
                if viewModel.isLoading {
                    ProgressView()
                }
            }
            .navigationBarTitle("Profile", displayMode: .inline)
        }.onAppear{
            viewModel.apiPostList(uid: uid)
            viewModel.apiLoadUser(uid: uid)
            viewModel.apiLoadFollowing(uid: uid)
            viewModel.apiLoadFollowers(uid: uid)
        }
    }
}

struct OthersProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        OthersProfileScreen(uid: "1", user: User(uid: "1", email: "hakmirzaevbekhruzjon@gmail.com", displayName: "bekhruzjon"))
    }
}

