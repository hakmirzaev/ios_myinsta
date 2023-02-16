//
//  HomeLikesScreen.swift
//  ios_myinsta
//
//  Created by Bekhruz Hakmirzaev on 15/02/23.
//

import SwiftUI

struct HomeLikesScreen: View {
    @ObservedObject var viewModel = LikesViewModel()
    var body: some View {
        NavigationView{
            ZStack{
                List{
                    ForEach(viewModel.items, id: \.self){ item in
                        PostCell(post: item).listRowInsets(EdgeInsets())
                    }
                }.listStyle(PlainListStyle())
            }
            
            .navigationBarTitle("Likes", displayMode: .inline)
        }.onAppear{
            viewModel.apiPostList {
                print(viewModel.items.count)
            }
        }
    }
}

struct HomeLikesScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeLikesScreen()
    }
}