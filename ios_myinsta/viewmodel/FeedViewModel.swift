
import Foundation
import UIKit

class FeedViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var items: [Post] = []
    
    func  apiFeedList(uid: String) {
        isLoading = true
        items.removeAll()
        
        DatabaseStore().loadFeeds(uid: uid, completion: {posts in
            self.items = posts!
            self.isLoading = false
        })
    }
    
    func apiLikePost(uid: String, post: Post){
        DatabaseStore().likeFeedPost(uid: uid, post: post)
    }
    
    func apiRemovePost(uid: String, post: Post) {
        DatabaseStore().removeMyPost(uid: uid, post: post)
        apiFeedList(uid: uid)
    }
    
    func shareButton(){
        let url = URL(string: "https://designcode.io")
        let activityController = UIActivityViewController(activityItems: [url!], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController!.present(activityController, animated: true, completion: nil)
    }
}
