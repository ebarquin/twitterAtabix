
import UIKit
import Kingfisher

class TweetDetailViewController: UIViewController {

    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var twitterUser: UILabel!
    @IBOutlet weak var twitterImage: UIImageView!
    @IBOutlet weak var twitterText: UILabel!
    
    let dataProvider = LocalCoreDataService()
    var tweet: Tweet?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        self.navigationController?.navigationBar.tintColor = UIColor.white
    
        if let tweet = tweet {
            
            if let image = tweet.image {
                twitterImage.kf.setImage(with: ImageResource(downloadURL: URL(string: image)!))
            }
            
            twitterUser.text = tweet.user
            twitterText.text = tweet.text
            self.title = tweet.user
            
            
            
            configureFavoriteButton()
        }
    }
    
    func configureFavoriteButton() {
        if let tweet = self.tweet {
            if dataProvider.isTweetFavorite(tweet: tweet){
                favoriteButton.setImage(#imageLiteral(resourceName: "tweet_favorite_on"), for: .normal)
                
            } else {
                favoriteButton.setImage(#imageLiteral(resourceName: "tweet_favorite_off"), for: .normal)
            }
        }
        
    }

    @IBAction func favoritePressed(_ sender: UIButton) {
        if let tweet = self.tweet {
            dataProvider.markUnmarkFavorite(tweet: tweet)
            configureFavoriteButton()
        }
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "userDetailSegue" {
                let detailVC = segue.destination as! UserDetailViewController
                let tweet = Tweet(id: self.tweet?.id, user: self.tweet?.user, text: self.tweet?.text, image: self.tweet?.image, userId: self.tweet?.userId)
                detailVC.tweet = tweet
        }

    }

}

   


