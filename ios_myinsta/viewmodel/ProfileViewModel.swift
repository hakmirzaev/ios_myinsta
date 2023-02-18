
import Foundation

class ProfileViewModel: ObservableObject{
    @Published var isLoading = false
    @Published var items: [Post] = []
    
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
}
