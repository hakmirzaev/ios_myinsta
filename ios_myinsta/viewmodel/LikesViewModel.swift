

import Foundation

class LikesViewModel: ObservableObject{
    @Published var isLoading = false
    @Published var items: [Post] = []
    
    func apiPostList(completion: @escaping () -> ()) {
        isLoading = true
        items.removeAll()
        
        self.items.append(Post(title: "Bekhruzjon", content: "February 16, 2022", imgUrl: Utils.image1))
        self.items.append(Post(title: "Bekhruzjon", content: "February 16, 2022", imgUrl: Utils.image2))
        self.items.append(Post(title: "Bekhruzjon", content: "February 16, 2022", imgUrl: Utils.image1))
        self.items.append(Post(title: "Bekhruzjon", content: "February 16, 2022", imgUrl: Utils.image2))
        self.items.append(Post(title: "Bekhruzjon", content: "February 16, 2022", imgUrl: Utils.image1))
        self.items.append(Post(title: "Bekhruzjon", content: "February 16, 2022", imgUrl: Utils.image2))
        
        isLoading = false
        completion()
    }
    
}
