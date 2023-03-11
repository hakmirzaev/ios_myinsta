//
//  HomeFeedScreen.swift
//  ios_myinsta
//
//  Created by Bekhruz Hakmirzaev on 15/02/23.
//

import SwiftUI

struct HomeFeedScreen: View {
    @EnvironmentObject var session: SessionStore
    @Binding var tabSelection: Int
    @ObservedObject var viewModel = FeedViewModel()
    var body: some View {
        NavigationView{
            ZStack{
                List{
                    ForEach(viewModel.items, id: \.self){ item in
                        if let uid = session.session?.uid! {
                            FeedPostCell(uid:uid, viewModel: viewModel, post: item)
                                .listRowInsets(EdgeInsets())
                        }
                    }
                }.listStyle(PlainListStyle())
                if viewModel.isLoading {
                    ProgressView()
                }
            }
            .navigationBarItems(trailing: Button(action: {
                self.tabSelection = 2
            }, label: {
                Image(systemName: "camera").resizable().foregroundColor(.black).font(.system(size: 15))
            }))
            .navigationBarTitle("Instagram", displayMode: .inline)
        }.onAppear{
            if let uid = session.session?.uid! {
                viewModel.apiFeedList(uid: uid)
            }
        }
    }
}

struct HomeFeedScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeFeedScreen(tabSelection: .constant(0))
    }
}
