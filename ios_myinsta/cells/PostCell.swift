//
//  PostCell.swift
//  ios_myinsta
//
//  Created by Bekhruz Hakmirzaev on 16/02/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct PostCell: View {
    var post: Post
    var body: some View {
        VStack(spacing: 0){
            HStack{
                VStack{
                    Image("ic_person").resizable().clipShape(Circle())
                        .frame(width: 46, height: 46)
                        .padding(.all, 2)
                }.overlay(RoundedRectangle(cornerRadius: 25).stroke(Utils.color2, lineWidth: 2))
                VStack(alignment: .leading){
                    Text(post.title!)
                        .foregroundColor(.black)
                        .font(.system(size: 17))
                        .fontWeight(.medium)
                    Text(post.content!)
                        .foregroundColor(.gray)
                        .font(.system(size: 15))
                }
                Spacer()
                Button(action: {
                    
                }, label: {
                    Image("ic_more").font(.system(size: 15)).foregroundColor(.black)
                })
            }.padding(.top, 15).padding(.leading, 15).padding(.trailing, 15)
            
            WebImage(url: URL(string: post.imgUrl!))
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
                Text("Make a symbolic breakboint at UIView, category in UIViewlisted in")
                    .foregroundColor(.black)
                    .font(.system(size: 16))
                    Spacer()
            }.padding(.all, 15)
        }
    }
}

struct PostCell_Previews: PreviewProvider {
    static var previews: some View {
        PostCell(post: Post(title: "Bekhruzjon", content: "February 16, 2022", imgUrl: Utils.image1))
    }
}
