# lbc

Hello, and welcome to this repository.
To start the project, simply clone it and open the project (tested with Xcode 11.7 and 12.0.1).
```shell
git clone https://github.com/leobouilloux/lbc.git
cd lbc
open LBC.xcodeproj
```
<br/>

## Architecture
The project has been built using the MVVM-C (Model View ViewModel and Coordinators) architecture.
For each screen the following classes are created:
- ViewController (contains view + view interactions)
- ViewModel (handle and interact with the data that will be used by the ViewController)
- ViewModelInterface (interface for the viewModel to allow multiple implementations for example)

## Coordinators
Coordinators are a great way to handle navigation outside of ViewControllers.
The main benefit is that you can use any ViewController in any context without writting complex code to handle different cases.
Here is the current implementation of the project:
```
ApplicationCoordinator
|
| > SplashScreenCoordinator
|   |
|   | > SplashScreenPresentable
|
| > MainCoordinator
|   |
|   | > ItemsListPresentable
|   | > ItemDetailsPresentable
|   | > CategoriesFilterPresentable
```
## Assets and localization
The application is translated in french and english.
I've been using swiftgen by the past, and I wanted to reproduce this logic.
I created Assets.swift and Localizable.swift to do the same work.
Here is the benefit:
```swift
// we need to implicitly type the asset name, and there's no scope facilities
let image = UIImage(named: "close")
let localizable = NSLocalizedString("splashScreen.caption", comment: "")

// Swiftgen like assets loading, sorted by scope, with autocompletion
let image = Assets.Icons.close
let localizable = Loc.SplashScreen.caption
```

## Style
Since the application needs to compile with iOS 11 and above versions, I created a Style.swift enum to help with darkmode.
Here is an example of use:
```swift
enum Style {
  enum CustomComponent {
    var backgroundColor: UIColor {
      if #available(iOS 13, *) {
        return .systemBackgroundColor
      } else {
        return .white
      }
    }
  }
}

// Usage
let customComponent = CustomComponent()
customComponent.backgroundColor = Style.CustomComponent.backgroundColor
```

## Tools
I have a private repository containing a few swift files with different tools.
I used some of them for this project but I had to modify them to remove external libs such as RxCocoa/RxSwift
If needed, I can show you this repository content

## Data provider
I implemented a very simple Provider protocol with one method to fetch data.
This protocol has 2 implementations:
- NetworkProvider (used in the app, makes a call to the json url)
- MockupProvider (load a json locally, for unit and functional tests)

## ImageLoader
Since I never built an ImageLoader without external frameworks, I found some source of inspiration on the web (https://medium.com/better-programming/how-to-efficiently-load-images-in-uitableviews-and-uicollectionviews-a39afd608b1a)
This ImageLoader store operations in a queue and can cancel them to help with performande (for cells in UITableView for example).


## Unit tests
I wrote tests using GWT style (GIVEN > WHEN > THEN)
Since I was runing out of time, I've done 2 kinds of unit tests.
One for the provider (MockupProvider) with async calls.
One for ItemsListViewModel to test how the attributes are modified.

## Functional tests
Due to the lack of time, I wasn't able to write a functional test.
I have done some of them by the past, so we can discuss this part.

## Linter
I know external frameworks were prohibited for this project, but I couldn't resist to install swiftlint locally to improve the code quality.
My .swiftgen.yml file is on the repo so you can have a look on the rules I am using.
