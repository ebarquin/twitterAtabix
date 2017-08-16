
import Foundation

extension TweetManaged {
    
    func mappedObject() -> Tweet {
        return Tweet(id: self.id, user: self.user, text: self.text, image: self.image, userId: self.userId)
    }
}
