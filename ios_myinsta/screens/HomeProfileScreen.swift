//
//  HomeProfileScreen.swift
//  ios_myinsta
//
//  Created by Bekhruz Hakmirzaev on 15/02/23.
//

import SwiftUI

struct HomeProfileScreen: View {
    @ObservedObject var viewModel = ProfileViewModel()
    
    @State var level = 2
    @State var columns: [GridItem] = Array(repeating: GridItem(.flexible(minimum: UIScreen.width/2 - 15)), count: 2)
    
    func postSize() -> CGFloat {
        if level == 1 {
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
                            Image("ic_person").resizable().clipShape(Circle())
                                .frame(width: 70, height: 70)
                                .padding(.all, 2)
                        }.overlay(RoundedRectangle(cornerRadius: 37).stroke(Utils.color2, lineWidth: 2))
                        HStack{
                            Spacer()
                            VStack{
                                Spacer()
                                Button(action: {
                                    
                                }, label: {
                                    Image(systemName: "plus.circle.fill")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                })
                            }
                        }.frame(width: 77, height: 77)
                    }
                    Text("Bekhruz Hakmirzaev").foregroundColor(.black)
                        .font(.system(size: 17))
                        .fontWeight(.medium)
                        .padding(.top, 15)
                    Text("hakmirzaevb@gmail.com").foregroundColor(.black)
                        .font(.system(size: 17))
                        .fontWeight(.medium)
                        .padding(.top, 3)
                    
                    //post, following, followers count
                    HStack{
                        VStack{
                            Text("625").foregroundColor(.black)
                                .font(.system(size: 17))
                                .fontWeight(.medium)
                            Text("Posts").foregroundColor(.gray)
                                .font(.system(size: 15))
                        }.frame(maxWidth: UIScreen.width/3, maxHeight: 60)
                        VStack{}.frame(maxWidth: 1, maxHeight: 25)
                            .background(.black.opacity(0.5))
                        VStack{
                            Text("4,235").foregroundColor(.black)
                                .font(.system(size: 17))
                                .fontWeight(.medium)
                            Text("Followers").foregroundColor(.gray)
                                .font(.system(size: 15))
                        }.frame(maxWidth: UIScreen.width/3, maxHeight: 60)
                        VStack{}.frame(maxWidth: 1, maxHeight: 25)
                            .background(.black.opacity(0.5))
                        VStack{
                            Text("897").foregroundColor(.black)
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
                                MyPostCell(post: item, length: postSize())
                            }
                        }
                    }.padding(.top, 10)
                }.padding(.all, 20)
            }
            .navigationBarItems(trailing: Button(action: {
                
            }, label: {
                Image(systemName: "pip.exit").font(.system(size: 15))
            }))
            .navigationBarTitle("Profile", displayMode: .inline)
        }.onAppear{
            viewModel.apiPostList {
                print(viewModel.items.count)
            }
        }
    }
}

struct HomeProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeProfileScreen()
    }
}
