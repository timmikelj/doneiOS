# Do, Done.
### AI POWERED TO-DO APP
When you add a new item it’s text is scanned with Language Recognising Engine which searches for verbs/nouns in the input text.

![](App%20Screenshots/done_screenshot.png)

Found noun/verb is then used as a search text for images via Pixabay API - as soon a image is found and downloaded successfully it will display next to the to-do item in the list - this is subject to your network availability.

Note that nouns found in input item text are always preferred to verbs while searching for images.

### APP RECOGNISES YOUR TO-DO ITEMS
To-do list app using natural language recognition to find verbs and nouns in your input item which it then uses to find and download custom image to your to-do item.

### POWER OF ARTIFICIAL INTELLIGENCE
App downloads custom images to show next to your to-do items -> i.e. if you add an item called "buy a car" the app will find a noun “car”, search for an image of a car and attempt to download it in order to show next to your to-do item. 

App also caches all your items so no need to worry to lose your to-do list!

You will need a stable internet connection in order for the app to able to find and download images.

All images are downloaded from Pixabay.

### TECH USED TO DEVELOP
* Written in Objective-c
* Used MVVM architectural pattern
* Using Realm database to store and query to-do items - using cocoapods dependency manager
* Screens are modular and can be reused in any context
* Using Realm database to store and query to-do items
* Using Natural Language recognition native framework to add custom images to to-do items (NLTagger)
How does that work? i.e. if you add an item called "buy a car" the app tries to fetch and show an image of a car besides to-do item.
* Using Pixabay public REST API to download image with a search term retrieved from Natural Language Recognition framework
* Added a few unit tests to cover Realm and Natural Language Recognition 
