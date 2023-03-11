//
//  PostCell.swift
//  ios_myinsta
//
//  Created by Bekhruz Hakmirzaev on 16/02/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct FeedPostCell: View {
    @EnvironmentObject var session: SessionStore
    @State private var showingAlert = false
    var uid: String
    var viewModel: FeedViewModel
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
                }.overlay(RoundedRectangle(cornerRadius: 25).stroke(Utils.color2, lineWidth: 2))
                VStack(alignment: .leading){
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
            }.padding(.top, 15).padding(.leading, 15).padding(.trailing, 15)
            
            WebImage(url: URL(string: post.imgPost!))
                .resizable().scaledToFit()
                .padding(.top, 15)
            HStack{
                Button(action: {
                    
                }, label: {
                    Image("ic_like_off").resizable().frame(width: 25, height: 25)
                        .foregroundColor(.black)
                })
                Button(action: {
                    
                }, label: {
                    Image("ic_share").resizable().frame(width: 25, height: 25)
                        .foregroundColor(.black)
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

struct FeedPostCell_Previews: PreviewProvider {
    static var previews: some View {
        FeedPostCell(uid: "uid", viewModel: FeedViewModel(), post:  Post(caption: "symbolic", imgPost: Utils.image1))
    }
}
