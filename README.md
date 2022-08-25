# QuickGit
QuickGit is a native iOS Github client with searching and offline bookmarking capabilities. \
The app was written in Swift 5.6 using the MVVM pattern.

## Screenshots
<a href="https://imgur.com/zKALpmw"><img src="https://i.imgur.com/zKALpmwl.png" title="source: imgur.com" /></a>
<a href="https://imgur.com/yb2o75i"><img src="https://i.imgur.com/yb2o75il.png" title="source: imgur.com" /></a>
<a href="https://imgur.com/3Cp9KU0"><img src="https://i.imgur.com/3Cp9KU0l.png" title="source: imgur.com" /></a>
<a href="https://imgur.com/WGorTzR"><img src="https://i.imgur.com/WGorTzRl.png" title="source: imgur.com" /></a>
<a href="https://imgur.com/GzaJCm2"><img src="https://i.imgur.com/GzaJCm2l.png" title="source: imgur.com" /></a>
<a href="https://imgur.com/Sfy3IUm"><img src="https://i.imgur.com/Sfy3IUml.png" title="source: imgur.com" /></a>
<a href="https://imgur.com/fcJHEqW"><img src="https://i.imgur.com/fcJHEqWl.png" title="source: imgur.com" /></a>
<a href="https://imgur.com/pAdoWNf"><img src="https://i.imgur.com/pAdoWNfl.png" title="source: imgur.com" /></a>

## Features
- Explore Github Repositories and Users
- View commits on your favourite repositories
- Infinte Scrolling in lists using pagination
- Live search capabilities using UISearchControllers
- Authenticated mode using OAuth 2.0
- Offline bookmarking options using CoreData
- Long Press Context Menu using UILongPressGestureRecognizer
- Dark Mode Control Option

## Fixed Issues in the last commit
- Fixed an issue where recent search suggestions don't show up.
- Fixed the request quota problem by switching from search on type to search on editing end

## Todo list
- Fixing Recent Search View
- Improving Code Structure
- Adding Arabic Language Support
- Adding Issues View
- Some tweaks to the explore tab and adding customistation options to it

## Installation
- Open your github account and [register a new OAuth application](https://github.com/settings/applications/new)
- Clone the repository to your local device
- Set your callback URL as `quickgitcat://callback`
- If you choose a different callback URL you'll have to change your iOS app's URL scheme. Otherwise, the app won't reopen after authorization.
- Set up an APIKeys struct in your project filling it with with your client ID and client Secret
```
struct APIKeys {
    static let clientID = "ENTER_YOUR_CLIENT_ID"
    static let clientSecret = "ENTER_YOUR_CLIENT_SECRET"
}
```

## Contact
For any issues, you can contact me here\
[LinkedIn](https://www.linkedin.com/in/lefathy/) | [GMail](mailto:ahmedfathy.mha@gmail.com)
