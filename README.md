# teamwork-api-sample

## Introduction

This is a sample iOS app using the Teamwork API. The app shows a list of all projects the user has access and some details for each project. Entirely built in Swift.

## Getting Started

First make sure you have Cocoapods installed, since this project use's some dependencies from it. Go to the projects root folder and execute `pod install` command. Remember to open the `.xcworkspace` file after doing so.

You should now be able to compile the project, but you won't be able to see any projects, the app will be complaining about your credentials. Because login was out of the scope of this sample, we have to add an API key from the Teamwork project website to the Environment Variables. To get your API key, refere to Teamwork's API documentation:  http://developer.teamwork.com. To add your API key as Environment Variable of the project, open Xcode, click on the app's target and choose 'Edit Scheme', click on 'Run' on the left pane if it is not selected and select the 'Arguments' tab, there you should see the 'Environment Variables' section where you should add your API key with the variable name 'API_KEY'. Storing the API key this way was done for security and convenience purposes.

Now you can run the project again and your projects should be listed.

## Some Specs

This project was developed having MVVM in mind, so you should find a View Controller acompanied by its respective View Model. This project also uses some concepts from reactive programming using the RxSwift framework. Alamofire, a widely used HTTP networking framework, to make the HTTP requests. For downloading and caching images it was used Kingfisher, a lightweight framework for doing so.
