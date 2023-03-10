//
//  HomeProfileScreen.swift
//  ios_myinsta
//
//  Created by Bekhruz Hakmirzaev on 15/02/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomeProfileScreen: View {
    @ObservedObject var viewModel = ProfileViewModel()
    @EnvironmentObject var session: SessionStore
    @State var action = false
    @State var isImagePickerDisplay = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var selectedImage: UIImage?
    @State var showingAlert = false
    
    @State var level = 2
    @State var columns: [GridItem] = Array(repeating: GridItem(.flexible(minimum: UIScreen.width/2 - 15)), count: 2)
    
    func postSize() -> CGFloat {
        if level == 1 {
            return UIScreen.width/CGFloat(level) - 20
        }
        return UIScreen.width/CGFloat(level) - 15
    }
    
    func uploadImage(){
        let uid = (session.session?.uid)!
        viewModel.apiUploadMyImage(uid: uid, image: selectedImage!)
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
                        
                        HStack{
                            Spacer()
                            VStack{
                                Spacer()
                                Button(action: {
                                    self.action.toggle()
                                }, label: {
                                    Image(systemName: "plus.circle.fill")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                }).actionSheet(isPresented: $action, content: {
                                    ActionSheet(title: Text("Actions"), buttons: [
                                        .cancel(),
                                        .default(Text("Pick Photo")) {
                                            self.sourceType = .photoLibrary
                                            self.isImagePickerDisplay.toggle()
                                        },
                                        .default(Text("Take Photo")) {
                                            self.sourceType = .camera
                                        }
                                    ])
                                })
                                .sheet(isPresented: $isImagePickerDisplay, onDismiss: uploadImage, content: {
                                    ImagePickerView(selectedImage: self.$selectedImage, sourceType: self.sourceType)
                                })
                            }
                        }.frame(width: 77, height: 77)
                    }
                    Text(viewModel.displayName).foregroundColor(.black)
                        .font(.system(size: 17))
                        .fontWeight(.medium)
                        .padding(.top, 15)
                    Text(viewModel.email).foregroundColor(.black)
                        .font(.system(size: 17))
                        .fontWeight(.medium)
                        .padding(.top, 3)
                    
                    //post, following, followers count
                    HStack{
                        VStack{
                            Text("\(viewModel.items.count)").foregroundColor(.black)
                                .font(.system(size: 17))
                                .fontWeight(.medium)
                            Text("Posts").foregroundColor(.gray)
                                .font(.system(size: 15))
                        }.frame(maxWidth: UIScreen.width/3, maxHeight: 60)
                        VStack{}.frame(maxWidth: 1, maxHeight: 25)
                            .background(.black.opacity(0.5))
                        VStack{
                            Text("\(viewModel.followers.count)").foregroundColor(.black)
                                .font(.system(size: 17))
                                .fontWeight(.medium)
                            Text("Followers").foregroundColor(.gray)
                                .font(.system(size: 15))
                        }.frame(maxWidth: UIScreen.width/3, maxHeight: 60)
                        VStack{}.frame(maxWidth: 1, maxHeight: 25)
                            .background(.black.opacity(0.5))
                        VStack{
                            Text("\(viewModel.following.count)").foregroundColor(.black)
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
                        LazyVGrid(columns: columns, spacing: 10) {
                            ForEach(viewModel.items, id: \.self){ item in
                                if let uid = session.session?.uid! {
                                    MyPostCell(uid:uid,viewModel: viewModel,post: item, length: postSize())
                                }
                            }
                        }
                    }.padding(.top, 10)
                }.padding(.all, 20)
                if viewModel.isLoading {
                    ProgressView()
                }
            }
            .navigationBarItems(trailing: Button(action: {
                self.showingAlert.toggle()
            }, label: {
                Image(systemName: "pip.exit").font(.system(size: 15))
            }).alert(isPresented: $showingAlert, content: {
                Alert(title: Text("Signout"), message: Text("Do you want to signout?"), primaryButton: .destructive(Text("Confirm"), action: {
                    viewModel.apiSignOut()
                }), secondaryButton: .cancel())
            })
            )
            .navigationBarTitle("Profile", displayMode: .inline)
        }.onAppear{
            let uid = (session.session?.uid)!
            viewModel.apiPostList(uid: uid)
            viewModel.apiLoadUser(uid: uid)
            viewModel.apiLoadFollowing(uid: uid)
            viewModel.apiLoadFollowers(uid: uid)
        }
    }
}

struct HomeProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeProfileScreen()
    }
}
