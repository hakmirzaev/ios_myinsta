
import Foundation
import SwiftUI

class OthersProfileViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var items: [Post] = []
    @Published var userList: [User] = []
    
    @Published var email = ""
    @Published var displayName = ""
    @Published var imgUser = ""
    
    @Published var following: [User] = []
    @Published var followers: [User] = []
    
    func apiPostList(uid: String) {
        isLoading = true
        items.removeAll()
        
        DatabaseStore().loadPosts(uid: uid, completion: {posts in
            self.items = posts!
            self.isLoading = false
        })
    }
    
    func apiLoadUser(uid: String) {
        DatabaseStore().loadUser(uid: uid, completion: {user in
            self.email = (user?.email)!
            self.displayName = (user?.displayName)!
            self.imgUser = (user?.imgUser)!
            print(self.imgUser)
        })
    }
    
    func apiLoadFollowing(uid: String) {
        isLoading = true
        items.removeAll()
        
        DatabaseStore().loadFollowing(uid: uid, completion: {users in
            self.following = users!
            self.isLoading = false
        })
    }
    
    func apiLoadFollowers(uid: String) {
        isLoading = true
        items.removeAll()
        
        DatabaseStore().loadFollowers(uid: uid, completion: {users in
            self.followers = users!
            self.isLoading = false
        })
    }
    
    func apiUserList(uid: String, keyword: String){
        isLoading = true
        self.items.removeAll()
        
        DatabaseStore().loadUsers(keyword: keyword){ users in
            DatabaseStore().loadFollowing(uid: uid){ following in
                self.userList = self.mergeUsers(uid: uid, users: users!, following: following!)
                self.isLoading = false
            }
        }
    }
    
    func mergeUsers(uid: String, users: [User], following: [User]) -> [User]{
        var items: [User] = []
        
        for u in users {
            var user = u
            for f in following {
                if u.uid == f.uid {
                    user.isFollowed = true
                    break
                }
            }
            if uid != user.uid {
                items.append(user)
            }
        }
        return items
    }
    
    func apiFollowUser(uid: String, to: User){
        DatabaseStore().loadUser(uid:uid){ me in
            DatabaseStore().followUser(me: me!, to: to){isFollowed in
                self.apiUserList(uid: uid, keyword: "")
            }
        }
    }
    
    func apiUnFollowUser(uid: String, to: User){
        DatabaseStore().loadUser(uid:uid){ me in
            DatabaseStore().unFollowUser(me: me!, to: to){isFollowed in
                self.apiUserList(uid: uid, keyword: "")
            }
        }
    }
}
