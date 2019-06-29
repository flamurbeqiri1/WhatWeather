# WhatWeather
WhatWeather - iOS Weather app built in MVC and Dependency Injection. Some Unit tests included.

Services are listed below:
  - **Backend Service** - that uses Alamofire library for network communication
  - **Image Service** - getting and caching images using Nuke Library
  - **Weather service** - that use both above services to list cities and returning images.
  
# APP Features!
  - Listing some cities
  - Pull to refresh
  - Detail info
  - Sharing
  - Animations

Using Seguhandler in view controllers:
  - 1) Have view controller conform to SegueHandlerType
  - 2) Add `enum SegueIdentifier: String { }` to conformance
  - 3) Manual segues are trigged by `performSegue(with:sender:)`
  - 4) `prepare(for:sender:)` does a `switch segueIdentifier(for: segue)` to select the appropriate segue case

## Developer ##
    * Flamur Beqiri

## Cocoapods ##
    * Using Nuke
    * Using Alamofire
    * Using SwiftLint
    
### Pods documentation ###
    * Nuke: https://github.com/kean/Nuke
    * Alamofire: https://github.com/Alamofire/Alamofire
    * SwiftLint: https://github.com/realm/SwiftLint
