# Coordinators

[![CI Status](https://travis-ci.org/Bitdreams/Coordinators.svg?branch=master)](https://travis-ci.org/Bitdreams/Coordinators)
[![Version](https://img.shields.io/cocoapods/v/Coordinators.svg?style=flat)](http://cocoapods.org/pods/Coordinators)
[![License](https://img.shields.io/cocoapods/l/Coordinators.svg?style=flat)](http://cocoapods.org/pods/Coordinators)
[![Platform](https://img.shields.io/cocoapods/p/Coordinators.svg?style=flat)](http://cocoapods.org/pods/Coordinators)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

Coordinators is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'Coordinators'
```

## Coordinators

A Coordinator is an object that owns a discrete section of your app's logic. One common practise is to use one Coordinator per [user story](https://en.wikipedia.org/wiki/User_story). When coupled with MVVM, the Coordinator becomes the ideal place to convert your model to a view model and vice-versa, instantiate the view controller with the view model and pushing it to the navigation stack. The Coordinator should also be responsible from bridging your business logic for the user story (which should be contained within the view model) with the service layer of your application (e.g. networking with your API, persisting data on Realm or Core Data, etc).

![An example of a group of Coordinators dealing with the Sign In flow of an app](/images/coordinators.png)

A single Coordinator can have from zero to n children meaning your application flow gets represented as a tree structure. When moving to a new user story, the current coordinator should instantiate the appropriate new coordinator and start it. The new coordinator becomes a part of the tree when started and removes itself when finished.

## Author

Raphael Cruzeiro, raphael@bitdreams.co

## License

Coordinators is available under the MIT license. See the LICENSE file for more info.
