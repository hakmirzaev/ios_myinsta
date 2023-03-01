
import Foundation

class SearchViewModel: ObservableObject{
    @Published var isLoading = false
    @Published var items: [User] = []
    
    func apiUserList(uid: String, keyword: String){
        isLoading = true
        self.items.removeAll()
        
        DatabaseStore().loadUsers(keyword: keyword, completion: {users in
            self.items = users!
            self.isLoading = false
        })
    }
}
