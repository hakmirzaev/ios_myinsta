
import Foundation
import Combine

class SessionStore: ObservableObject {
    var didChange = PassthroughSubject<SessionStore, Never>()
    @Published var session: User? {didSet{self.didChange.send(self)}}
    
    func listen() {
        self.session = User(uid: "asd", email: "asd", displayName: "asd")
//        self.session = nil
    }
}
