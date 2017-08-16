

import UIKit
import Kingfisher


class FavoritesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let dataProvider = LocalCoreDataService()
    var tweets: [Tweet] = [Tweet]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
        
        self.automaticallyAdjustsScrollViewInsets = false 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }

    func loadData() {
        if let tweets = dataProvider.getFavoriteTweets() {
            
            self.tweets = tweets
            self.collectionView.reloadData()
        }
    }

    //CollectionView Delegate
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if tweets.count > 0 {
            self.collectionView.backgroundView = nil
        } else {
            let imageView = UIImageView(image: UIImage(named: "nofavorites"))
            imageView.contentMode = .center
            self.collectionView.backgroundView = imageView
        }
        return tweets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CELL_IDENTIFIER, for: indexPath) as! TweetCell
        
        let tweet = tweets[indexPath.row]
        
        
        self.configureCell(cell: cell, tweet: tweet)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 375, height: 120)
    }
    
    func configureCell(cell: TweetCell, tweet: Tweet){
        if let imageData = tweet.image {
            cell.tweetImage.kf.setImage(with: ImageResource(downloadURL: URL(string: imageData)!), placeholder: #imageLiteral(resourceName: "place_holder"), options: nil, progressBlock: nil, completionHandler: nil)
        }
        
        if let text = tweet.text {
            cell.tweetText.text = text
        }
        
        if let user = tweet.user{
            cell.tweetUser.text = user
        }
    }
    


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailSegue" {
            if let indexPathSelected = collectionView.indexPathsForSelectedItems?.last {
                let selectedTweet = tweets[indexPathSelected.row]
                let detailVC = segue.destination as! TweetDetailViewController
                detailVC.tweet = selectedTweet
            }
        }
    }

}

