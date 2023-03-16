//
//  HomeSearchScreen.swift
//  ios_myinsta
//
//  Created by Bekhruz Hakmirzaev on 15/02/23.
//

import SwiftUI

struct HomeSearchScreen: View {
    @ObservedObject var viewModel = SearchViewModel()
    @EnvironmentObject var session: SessionStore
    @State var showProfile = false
    @State var keyword = ""
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    TextField("Search for user", text: $keyword)
                        .padding(.leading, 15).padding(.trailing, 15)
                        .frame(height: 45)
                        .font(.system(size: 16))
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(.black.opacity(0.5), lineWidth: 0.5))
                        .padding(.top, 20).padding(.leading, 20).padding(.trailing, 20)
                    List{
                        ForEach(viewModel.items,  id: \.self){ item in
                            let uid = (session.session?.uid)!
                            UserCell(uid: uid, user: item, viewModel: viewModel)
                                .onTapGesture {
                                    self.showProfile.toggle()
                                }
                                .sheet(isPresented: $showProfile, content: {
                                    OthersProfileScreen(uid: item.uid!, user: item)
                                })
                                .listRowInsets(EdgeInsets())
                                .buttonStyle(PlainButtonStyle())
                        }
                    }.listStyle(PlainListStyle())
                }
                if viewModel.isLoading {
                    ProgressView()
                }
            }
            .navigationBarTitle("Search", displayMode: .inline)
        }.onAppear{
            let uid = (session.session?.uid)!
            viewModel.apiUserList(uid: uid, keyword: keyword)
        }
    }
}

struct HomeSearchScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeSearchScreen()
    }
}
