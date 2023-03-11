
import Foundation
import SwiftUI

class ProfileViewModel: ObservableObject{
    @Published var isLoading = false
    @Published var items: [Post] = []
    
    @Published var email = ""
    @Published var displayName = ""
    @Published var imgUser = ""
    
    func apiPostList(uid: String) {
        isLoading = true
        items.removeAll()
        
        DatabaseStore().loadPosts(uid: uid, completion: {posts in
            self.items = posts!
            self.isLoading = false
        })
    }
    
    func apiSignOut() {
        isLoading = true
        SessionStore().signOut()
        isLoading = false
    }
    
    func apiLoadUser(uid: String) {
        DatabaseStore().loadUser(uid: uid, completion: {user in
            self.email = (user?.email)!
            self.displayName = (user?.displayName)!
            self.imgUser = (user?.imgUser)!
            print(self.imgUser)
        })
    }
    
    func apiUploadMyImage(uid: String, image: UIImage){
        self.isLoading = true
        StorageStore().uploadUserImage(uid: uid, image, completion: { downloadUrl in
            self.apiUpdateMyImage(uid: uid, imgUser: downloadUrl)
            self.apiLoadUser(uid: uid)
            self.isLoading = false
        })
    }
    
    func apiUpdateMyImage(uid: String, imgUser: String?){
        DatabaseStore().updateMyImage(uid:uid, imgUser: imgUser )
    }
}
