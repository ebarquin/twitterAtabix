

import Foundation
import CoreData

class LocalCoreDataService {

   let stack = CoreDataStack.sharedInstance
    func getTweetById(id: String, favorite: Bool) -> TweetManaged?{
        
        let context = stack.persistentContainer.viewContext
        let request: NSFetchRequest<TweetManaged> = TweetManaged.fetchRequest()
        
        let predicate = NSPredicate(format: "id = \(id) and favorite = \(favorite)")
        request.predicate = predicate
        
        do {
            
            let fetchedTweets = try context.fetch(request)
            if fetchedTweets.count > 0 {
                return fetchedTweets.last
            } else {
                return nil
            }
            
        } catch {
            print("Error while getting tweet from Core Data")
            return nil
        }
        
    }
    
    func getFavoriteTweets() -> [Tweet]? {
        
        let context = stack.persistentContainer.viewContext
        let request: NSFetchRequest<TweetManaged> = TweetManaged.fetchRequest()
        
        let predicate = NSPredicate(format: "favorite = \(true)")
        request.predicate = predicate
        
        do {
            let fetchedTweets = try context.fetch(request)
            
            var tweets: [Tweet] = [Tweet]()
            for managedTweet in fetchedTweets {
                tweets.append(managedTweet.mappedObject())
            }
            return tweets
            
        } catch {
            print("Error while getting favorites")
            return nil
        }
        
    }
    
    func isTweetFavorite(tweet: Tweet) -> Bool {
        if let _ = getTweetById(id: tweet.id!, favorite: true) {
            return true
        } else {
            return false
        }
        
    }
    
    func markUnmarkFavorite(tweet: Tweet) {
        let context = stack.persistentContainer.viewContext
        
        if let exist = getTweetById(id: tweet.id!, favorite: true) {
            context.delete(exist)
            do {
                try context.save()
                
            } catch {
                print("Error while unmarking as favorite")
        
            }
        
        } else {
            let favorite = TweetManaged(context: context)
            
            favorite.id = tweet.id
            favorite.user = tweet.user
            favorite.image = tweet.image
            favorite.text = tweet.text
            favorite.favorite = true
            favorite.userId = tweet.userId
            
            do {
                try context.save()
                
            } catch {
                print("Error while marking as favorite")
            }
        }
        updateFavoritesBadge()
        
        
    }
    
    //FavoriteBadge
    func updateFavoritesBadge() {
        if let totalFavorites = getFavoriteTweets()?.count {
            let notification = Notification(name: Notification.Name("updateFavoritesBadgeNotification"), object: totalFavorites, userInfo: nil)
            NotificationCenter.default.post(notification)
        }
    }
}































