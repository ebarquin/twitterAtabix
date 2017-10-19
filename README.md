# TWITTERATABIX
## BASIC INFORMATION

![TimeLineViewController](https://github.com/ebarquin/twitterAtabix/blob/master/ViewControllers/TimeLineViewController.png?raw=true)
![TweetDetailViewController](https://github.com/ebarquin/twitterAtabix/blob/master/ViewControllers/TweetDetailViewController.png?raw=true)
![UserDetailViewController](https://github.com/ebarquin/twitterAtabix/blob/master/ViewControllers/UserDetailViewController.png?raw=true)

iOS app developed in XCode 10.2 with Swift 3.0. TwitterAtabix is basically a tweeter reader that using Twitter API gets the timeline of the user. It also provides the option to save tweets in Core Data, so they are available offline.

I decided to use two different layers to deal with data, RemoteTwitterAPIService and LocalCoreDataService

#### RemoteTwitterAPIService 

It has the implementation  to connect with Twitter API, to get not only the timeline of the user, but also the profile's owner of selected tweet. Twitter API Authentication is done by ACAccountStore.

#### LocalCoreDataService

It has the implementation to deal with CoreData. Aditionally using NotificationCenter I also implement a badget that provides information about the number of tweets stored in Core Data.



## DEPENDENCIES
### CocoaPods

#### SwiftyJSON
[SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON) is a super-simplified JSON parsing library that gives you clearer syntax than the built-in iOS libraries, and better yet it's completely free.

#### KingFisher
[Kingfisher](https://github.com/onevcat/Kingfisher) is a lightweight, pure-Swift library for downloading and caching images from the web. This project is heavily inspired by the popular SDWebImage. It provides you a chance to use a pure-Swift alternative in your next app.


#### Install Cocoa Pods

- this installs the CocoaPods application
- CocoaPods is a Ruby gem
- do the same to update Cocoa Pods

```bash
$ sudo gem install cocoapods
```

---


#### Creating a Podfile

```
pod init
```


---

#### The Podfile


```ruby
platform :ios, '9.0'
use_frameworks! # Comment this if you're not using Swift 
                # and don't want to use dynamic frameworks

#inhibit_all_warnings!

project 'MyApp.xcodeproj'

target 'MyApp' do
  pod 'SwiftyJSON'
  pod 'KingFisher'
end
```

---

## Install pods

- Install project dependencies according to versions from a Podfile.loc
- creates a Workspace
    - __use the workspace!__

```bash
$ pod install

Analyzing dependencies
Downloading dependencies
Generating Pods project
Integrating client project
...
```

---

## Update / add / remove pods

1. edit Podfile
1. run `pod install` again

---


### ACAccountStore

The [ACAccountStore](https://developer.apple.com/documentation/accounts/acaccountstore) class provides an interface for accessing, manipulating, and storing accounts. To create and retrieve accounts from the Accounts database, you must create an ACAccountStore object. Each 
ACAccount object belongs to a single ACAccountStore object.

Twitter Authentication is pretty easy with this class but you must have Twitter account configured in your device, and obviusly you have to give permissions to TwitterAtabix to access to your Twitter Account.

Apparently this class is going to be deprecated in iOS 11, so alternatively we should implement OAuth2 Authentication.  


## TODO LIST

- OAuth2 Authenticate
- More functionalities using Twitter API



## Contributing

- If you spot an error / typo / dead link / something missing, please [file an issue](https://github.com/ebarquin/twitterAtabix/issues).
- Pull requests are welcome ;-)

## LICENSE

MIT - Licence

Copyright (c) 2017 Eugenio Barquin

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
