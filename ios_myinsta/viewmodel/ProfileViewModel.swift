
import Foundation
import SwiftUI

class ProfileViewModel: ObservableObject{
    @Published var isLoading = false
    @Published var items: [Post] = []
    
    @Published var email = ""
    @Published var displayName = ""
    @Published var imgUser = ""
    
    func apiPostList(completion: @escaping () -> ()) {
        isLoading = true
        items.removeAll()
        
        self.items.append(Post(title: "Bekhruzjon", content: "February 16, 2022", imgUrl: Utils.image1))
        self.items.append(Post(title: "Bekhruzjon", content: "February 17, 2022", imgUrl: Utils.image2))
        self.items.append(Post(title: "Bekhruzjon", content: "February 18, 2022", imgUrl: Utils.image1))
        self.items.append(Post(title: "Bekhruzjon", content: "February 19, 2022", imgUrl: Utils.image2))
        self.items.append(Post(title: "Bekhruzjon", content: "February 20, 2022", imgUrl: Utils.image1))
        self.items.append(Post(title: "Bekhruzjon", content: "February 21, 2022", imgUrl: Utils.image2))
        
        isLoading = false
        completion()
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
