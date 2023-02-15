//
//  HomeFeedScreen.swift
//  ios_myinsta
//
//  Created by Bekhruz Hakmirzaev on 15/02/23.
//

import SwiftUI

struct HomeFeedScreen: View {
    @Binding var tabSelection: Int
    var body: some View {
        NavigationView{
            ZStack{
                
            }
            .navigationBarItems(trailing: Button(action: {
                self.tabSelection = 2
            }, label: {
                Image(systemName: "camera").resizable().foregroundColor(.black).font(.system(size: 15))
            }))
            .navigationBarTitle("Instagram", displayMode: .inline)
        }
    }
}

struct HomeFeedScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeFeedScreen(tabSelection: .constant(0))
    }
}
