===

# Boiler Book

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
This app is a buying and selling app for textbooks between students at Purdue University. 

### App Evaluation
[Evaluation of your app across the following attributes]
- **Category:** Buying/Selling
- **Mobile:** This app would be primarily developed for mobile but will be just as viable on a computer. 
- **Story:** This makes it easier for students to find cheaper textbooks instead of buying from the original publisher. 
- **Market:** Purdue Students 
- **Habit:** This app would be used every semester when students enroll in new classes.
- **Scope:** First we would create an app where buyers and sellers can see how far they are from each other, sellers can rate the quality of the textbook and other aspects regarding their experience, and a chat option. We could broaden this idea by expanding it to different colleges and implementing an in-app purchase option. 

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* User can login
* User can create a new account
* User can see the main feed with all listings
* User can post their book to the feed (picture and comment)
* User can search for a book
* User can see rough location of seller/book
* Sold books marked as sold

**Optional Nice-to-have Stories**

* Users can chat with each other for buying/selling
* 

### 2. Screen Archetypes

* Login Screen
   * User can login
* Registration Screen
   * User can register for a new account
* Search
   * User can search for a certain book
* Listing
   * user can view the listing for a book
* Posting Page
   * User can click on an item on the feed to see the description/comment (see more details about the book)
* Creation
   * User can post a new book listing to the feed
* Message Overview
   * User can look at messages with people
* Message
   * User can message the selected user
* Profile
   * User can edit and view profile

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Search for a book
* Post a listing
* profile
* messages

**Flow Navigation** (Screen to Screen)

* Login Screen -> tab navigation (search), Registration Screen
* Registration Screen -> tab navigation (search)
* search -> Listing
* Listing -> Posting Page
* Posing Page -> Message
* Creation 
  * Search after posting
  * Navigate to camera/photo library
* Message Overview -> Message
* Profile -> NONE

## Wireframes
<img src="https://imgur.com/4UouzWw.png" width=600>

### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 
| Property      | Type          | Description   |
| ------------- | ------------- | ------------- |
| PostID        | String        | unique ID for each user |
| author        | CPointer to User | Book post author |



### Models
[Add table of models]
### Networking
- [Add list of network requests by screen ]
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]
