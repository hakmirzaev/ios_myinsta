
import Foundation

class SearchViewModel: ObservableObject{
    @Published var isLoading = false
    @Published var items: [User] = []
    
    func apiUserList(completion: @escaping () -> ()) {
        isLoading = true
        items.removeAll()
        
        items.append(User(uid: "1", email: "hakmirzaevb@gmail.com", displayName: "Bekhruzjon"))
        items.append(User(uid: "1", email: "hakmirzaevb@gmail.com", displayName: "Bekhruzjon"))
        items.append(User(uid: "1", email: "hakmirzaevb@gmail.com", displayName: "Bekhruzjon"))
        items.append(User(uid: "1", email: "hakmirzaevb@gmail.com", displayName: "Bekhruzjon"))
        items.append(User(uid: "1", email: "hakmirzaevb@gmail.com", displayName: "Bekhruzjon"))
        items.append(User(uid: "1", email: "hakmirzaevb@gmail.com", displayName: "Bekhruzjon"))
        items.append(User(uid: "1", email: "hakmirzaevb@gmail.com", displayName: "Bekhruzjon"))
        items.append(User(uid: "1", email: "hakmirzaevb@gmail.com", displayName: "Bekhruzjon"))
        
        isLoading = false
        completion()
    }
}
