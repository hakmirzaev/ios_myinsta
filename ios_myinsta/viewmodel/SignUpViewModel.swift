
import Foundation

class SignUpViewModel: ObservableObject {
    @Published var isLoading = false
    
    func apiSignUp(email: String, password: String, completion: @escaping (Bool) -> ()){
        self.isLoading = true
        SessionStore().signUp(email: email, password: password, handler: {(res, err) in
            self.isLoading = false
            if err != nil {
                print("Check email or password")
                completion(false)
            } else {
                print("user signed up")
                completion(true)
            }
        })
    }
}
