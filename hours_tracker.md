# 17:00 - 18:00

- Created texts file which will hold app used texts.
- Created Colors file which will hold app used colors.
- Created Themes file which will hold the general theme of app so we can reuse it whenever we want without hardcoding values each time.
- Moved the home screen long widget into a a tree of sub-widgets, refactoration of code, improvement & Edit of UI, fixed the overflow-bottom issue while typing in the text field.
- Moved the scan long widget to a tree of sub-widgets, refactoration of code, improvement & Edit of UI.

# 11:00 - 12:00

- Moved the bottom bar long widget screen to a tree of sub-widgets, refactoration of code.
- Made the bottom bar screen consistent with the bottom bar items in the home screen.
- Moved the messages long widget to a tree of sub-widgets, refactoration of code.

# 2:00 - 3:00

- Moved the profile long widget to a tree of sub-widgets, refactoration of code.
- Moved the chat, about and new post long widgets to a tree of sub-widgets, refactoration of code.
- separated partially Strings, colors, variables to single source of edit for reeuasbility.

# 1:30 - 2:30

- Implemented the main auth screen which generates a private key (with bottom-sheet of success) for the user with his name, and the locale caching of it for future use
- Implemented the auth screen for existent keys with caching as well for future use.
- refactored auth screen to chunks of sub widgets of both screens

# 2:00 - 3:00

- Implemented metadata setting after user creates account (private key).
- implementation of retrieval of that data for profile page.
- More refactoring of the global code.

# 3:00 - 3:00

- Implemented update profile metadata mechanism/UI.

# 2222222

# 8

- Implemented the basic tab for showing the current user posts/notes that shows directly text format of it. will be used for more advanced implementation
- Implemented more consistent way to manage relays websocket to get/send data from/to, will be very easy to implmeent a feature that ket the users manage them manually (adding, removing relays...)

# 9 - 10

- Implemented a global feed page that will be used easily for generating more customized feeds
- Implemented a basic bottom sheet that allow the user to add a new post/note to the relays

# 11

Added file upload method with that is based also on Nostr with nostr.build

# 12 - 13

IMplemented the show of the user's name/username, avatar, and date of the post he created in the post UI.

Implemented the reaction (like) functionality for posts & tested it

# 14 - 15

Implementation of single or multo images select and categories selection when posting and adding a new post to relays.

Improved the UI of the add new post bottom sheet, with error and success handling with snackbars.

# 16

Imlemntation of a comments section screen for each post, not completed yet but the basic functionality is there.

# 17

- global refactoring of the code, fixing some minor bugs in the whole app.

# 18

- Implementation of multiple feeds in addition of the global's for the user homepage, with rebuild fir a simple UI with custom islamic icons...

- Implementation for custom categories selection when adding posts to the targetted feeds.

# 3333333333333333

# 19-20

- Implementation of the UI and partial implementation of the custom advanced search for feeds, containing the search bar, search options, and a date range picker to search for posts in a specific date range.

- refactoring more widgets to be more reusable and more consistent with the app's.

# 21-22

- Implementation of the advanced search feature for feeds, it contains options for:

  - search by user public keys.
  - search by content of posts/notes.
  - search by specific date notations of Nostr date formats.
  - search by specific hashtags.
  - search for posts/notes that includes images.
  - search for posts in a specific date range.
    in addition if a reset button to reset the search options to default automatically.

- refactoring and separation of the code widgets to be more consistent and more reusable.

# 23

- Implementation of note cards methods for:
  - copying the note content.
  - copying the note id.
  - copying the note owner public key.
  - copying the whole serialized note event.

## 24-25

- Implementation of the profile current user's posts/notes screen, which shows the user's posts/notes in a list view with the ability to copy the note content, note id, note owner public key, and the whole serialized note event as well.

- Fixing the major scrolling overflow issue in the profile screen, caused by other nested scroll views.

# 26

- Implemented likes posts tab section in the user profile screen.

# 27

- Implementation of the profile avatar picking up from gallery or from the camera directly, then uploading ir to the nostr.build and setting it up in the profile metadata which will update the user's avatar in the app.
- Implementation the feature of deleting the profile totally for the user profile avatar.
- Implemented the feature of openeing the profile avatar in full screen mode.

# 28

- Implementation of the user's profile options bottom sheet, which allow users to:
  - navigate to the screen for editing the other profile metadata and informations.
  - Copy the user's public key.
  - Copying the user's metadata event.
  - Copying the user's metadata as json string.
  - copying the user's profile avatar url.
  - Copying the user's profile username.

# 29

- Implementation of followings mechanism in the app, which allow users to follow other users.

# 30

- Implementation of the followings feed which will show all the posts/notes of the users that the current user is following.

# 31-32

- Implementation of relays configuration, where a user can:
  - Toggle the relay on/off ti be used or not in the app.
  - Add new relays to the app.
  - Reconnect to relays if the connection is lost or when the relay is added in order to apply changes in the Nostr service.
  - Remove relays from the app.

# 33

- Implementation of tha onboarding skeleton for the app, which will be used to show the user some app's features and advantages and how to use it.

# 34

- Implementation of the relays informations (about) bottom sheet, which will give the options:
  - show some general relay informations such as name, decription..
  - show the connectivity status of the relay so the user will know if a relay is able to connect to or not.
  - another nested options shet where the user can see/copy the selected relay informations:
    - relay name.
    - relay description.
    - relay author public key.
    - relay contact
    - relay software that is used to run the relay.
    - relay software version.
    - relay's sipported nips.
- Implementation if the dynamic copy functionality for it's informations.

# 35 - 36

- Implementation of a simple profile sheet that give the user the ability to been redirected to euther the authentication with existent key or to create a new key pair.
- Implementation of a search bottom sheet where a user can put a pubKey or a Nostr identifier and expect to see a relevant user (profile) for that pubKey or identifier.
- Added the placeholder sheets for the dark mode switcher and the language switcher.
- Re-implemented the whole oboarding first screen UI with fancy animations and simple effective UI.
