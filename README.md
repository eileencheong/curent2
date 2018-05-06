# CURent

Peer-to-peer subleasing platform for Cornellians

Link to backend repository: (https://github.com/jpang7/A2)

## Feature highlights

* Login Screen - (https://drive.google.com/open?id=17kvfbrSh5eZZDxbsTl0pW1PFajfimNjD)
* Main Screen, Property Browser - (https://drive.google.com/open?id=1rvA6TVmA2L29dYIXt31rHO64CtR1TK2w)
* Property Browser Filtering Feature Demo - (https://drive.google.com/open?id=14w0xFx3piBFdQzpG-pwVbtEmDXXO5qE9)
* Add Property Screen - (https://drive.google.com/open?id=1G1pRjgUAp3sXddMLjaMAnij5G1Gk_M-a)
* Google Geocoding Autocompletion API Demo - (https://drive.google.com/open?id=1JlQDxWnwumoGOGLrjpR7EbHy1jKczBLa)


## Description

This app will provide users with a one-stop interface for exploring housing options around Cornell University. House owners can list their property on the app. Tenants will be able to contact the house owners to rent the entire property, or find subletting options.

The app uses a Google Maps Geocoding Autocompletion API to let users type in a part of their property address, then select the most relevant one from a list provided by Google.


## Challenge Requirement Compliance

The following requirements have been fulfilled by this app:

### Views and Navigation ###
* Uses Autolayout for all views
* Uses UICollectionView in the "Browser" page to display both the filters and housing options
* The transition from the login screen to the "Browser" page is a push transition and the navigation bar appears on the "Browser" page (it is hidden on the login page intentionally)
* Other pages are presented modally but still have the navigation controller visible

### API Integration ###
* Uses CocoaPods to manage the following integrations:
* Google Sign In API - *Users are able to authenticate themselves using their Google ID. The app pulls their name and personal information from Google to display it on listings.*
* Google Maps Geocoding Autocompletion API - *As the user types in the property address, the API autocompletes it for them and allows them to select it from the multiple options that are closest to the input.*


## Additional Important Information for Grader

The connection to backend hasn't been implemented yet.

## Contributors
* **Jaewon Sim** - *iOS Development*
* **Eileen Cheong** - *iOS Development*
* **Jonathan Pang** - *Backend*
* **Will Ostlund** - *Backend*
