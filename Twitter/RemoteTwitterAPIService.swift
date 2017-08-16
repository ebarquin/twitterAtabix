

import Foundation
import Social
import Accounts
import SwiftyJSON

class RemoteTwitterAPIService {
    
    func getTweets(completionHandler: @escaping ([Tweet]?) -> Void) {
        let account = ACAccountStore()
        let accountType = account.accountType(withAccountTypeIdentifier: ACAccountTypeIdentifierTwitter)
        account.requestAccessToAccounts(with: accountType, options: nil, completion: { (success, error) in
            
            if success {
                
                //We can access to Twitter credentials
                let arrayOfAccounts = account.accounts(with: accountType)
                if (arrayOfAccounts?.count)! > 0 {
                    let twitterAccount = arrayOfAccounts?.last as! ACAccount
                    let parameters = ["screen_name" : twitterAccount,
                                      "include_rts" : "0",
                                      "trim_user" : "0",
                                      "count" : "20"] as [String : Any]
                    let requestURL = URL(string: GET_TWEETS_API_URL)
                    let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, url: requestURL, parameters: parameters)
                    request?.account = twitterAccount
                    request?.perform(handler: { (data, HTTPResponse, error) in
                        
                        if error != nil {
                            print("Error getting tweets from API service")
                        }
                        
                        if let data = data {
                            let json = JSON(data)
                            var result = [Tweet]()
                            let entries = json.arrayValue
                                
                            for entry in entries {
                                
                                let id = entry["id"].stringValue
                                let user = entry["user"]["name"].stringValue
                                let text = entry["text"].stringValue
                                let image = entry["user"]["profile_image_url_https"].stringValue.replacingOccurrences(of: "normal", with: "200x200")
                                let userId = entry["user"]["id"].stringValue
                                
                                let tweet = Tweet(id: id, user: user, text: text, image: image, userId: userId)
                                result.append(tweet)
                            }
                            completionHandler(result)
                            
                        }
                        
                    })
                    
                }
                
            } else {
                print("Failed to access account")
                
            }
        })
        
    }
    
    func getFriends(user: String, completionHandler: @escaping ([User]?) -> Void) {
        let account = ACAccountStore()
        let accountType = account.accountType(withAccountTypeIdentifier: ACAccountTypeIdentifierTwitter)
        account.requestAccessToAccounts(with: accountType, options: nil, completion: { (success, error) in
            
            if success {
                
                //We can access to Twitter credentials
                let arrayOfAccounts = account.accounts(with: accountType)
                if (arrayOfAccounts?.count)! > 0 {
                    let twitterAccount = arrayOfAccounts?.last as! ACAccount
                    let parameters = ["user_id" : user] as [String : Any]
                    let requestURL = URL(string: GET_FRIENDS_API_URL)
                    let request = SLRequest(forServiceType: SLServiceTypeTwitter, requestMethod: SLRequestMethod.GET, url: requestURL, parameters: parameters)
                    request?.account = twitterAccount
                    request?.perform(handler: { (data, HTTPResponse, error) in
                        
                        if error != nil {
                            print("Error getting friends from API service")
                        }

                        if let data = data {
                            let json = JSON(data)
                            var result = [User]()
                            let entries = json["users"].arrayValue
                            
                            for entry in entries {
                                
                                let id = entry["id"].stringValue
                                let name = entry["screen_name"].stringValue
                                let image = entry["profile_image_url_https"].stringValue.replacingOccurrences(of: "normal", with: "200x200")
                                
                                
                                let user = User(name: name, id: id,  image: image)
                                result.append(user)
                            }
                            completionHandler(result)
                            
                        }
                        
                    })
                    
                }
                
            } else {
                print("Failed to access account")
                
            }
        })
        
    }
    

    
}
