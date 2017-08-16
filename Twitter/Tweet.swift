
import Foundation

class Tweet {
    let id: String?
    let user: String?
    let text: String?
    let image: String?
    let userId: String?
    init(id: String?, user: String?, text:String?, image: String?, userId: String?) {
        self.id = id
        self.user = user
        self.text = text
        self.image = image
        self.userId = userId
    }
}
