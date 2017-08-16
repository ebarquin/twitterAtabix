

import UIKit
import Kingfisher

class TimeLineViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var tweets: [Tweet] = [Tweet]()
    let refresh = UIRefreshControl()
    let dataProvider = RemoteTwitterAPIService()
    
    var tapGesture: UITapGestureRecognizer!


    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        self.automaticallyAdjustsScrollViewInsets = false 
        
        loadData()
        
        refresh.addTarget(self, action: #selector(loadData), for: UIControlEvents.valueChanged)
        collectionView.refreshControl = refresh



    }
    
    //TableView Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CELL_IDENTIFIER, for: indexPath) as! TweetCell
        
        let tweet = tweets[indexPath.row]
        
        
        self.configureCell(cell: cell, tweet: tweet)
        
        return cell
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
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
    
    func loadData() {
        
        dataProvider.getTweets(completionHandler:  { tweets in
            if let tweets = tweets {
                self.tweets = tweets
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.refresh.endRefreshing()
                }
            }
            
        
        })
        
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
