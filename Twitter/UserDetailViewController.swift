
import UIKit
import Kingfisher

class UserDetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var twitterImage: UIImageView!
    @IBOutlet weak var twitterUser: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let dataProvider = RemoteTwitterAPIService()
    
    var tweet: Tweet?
    var users : [User] = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        loadData()

    }
    
    //TableView Delegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CELL_IDENTIFIER, for: indexPath) as! UserCell
        
        let user = users[indexPath.row]
        
        
        self.configureCell(cell: cell, user: user)
        
        return cell
    }
    
    func configureCell(cell: UserCell, user: User){
        if let imageData = user.image {
            cell.userImage.kf.setImage(with: ImageResource(downloadURL: URL(string: imageData)!), placeholder: #imageLiteral(resourceName: "place_holder"), options: nil, progressBlock: nil, completionHandler: nil)
        }
        
        
        if let user = user.name{
            cell.userName.text = user
        }
        
        
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
            
    
        }
    }
    
    func loadData() {
        
        dataProvider.getFriends(user: (tweet?.userId)!) { users in
            if let users = users {
                self.users = users
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    
                }
            }
        }
    }

}









