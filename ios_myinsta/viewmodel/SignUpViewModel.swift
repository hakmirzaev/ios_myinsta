
import Foundation

class SignUpViewModel: ObservableObject {
    @Published var isLoading = false
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func isValidPassword(password: String) -> Bool {
        // least one uppercase,
        // least one digit
        // least one lowercase
        // least one symbol
        //  min 8 characters total
        let passwordRegx = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?.,/;'!@$%^&<>*~:`-]).{8,}$"
        let passwordCheck = NSPredicate(format: "SELF MATCHES %@",passwordRegx)
        return passwordCheck.evaluate(with: password)

    }
    
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
