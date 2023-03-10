
import Foundation

class LikesViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var items: [Post] = []
    
    func apiPostList(completion: @escaping () -> ()) {
        isLoading = true
        items.removeAll()
        
        
        isLoading = false
        completion()
    }
}
