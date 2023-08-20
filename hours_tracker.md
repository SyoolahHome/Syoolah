## 17:00 - 18:00

- Created texts file which will hold app used texts.
- Created Colors file which will hold app used colors.
- Created Themes file which will hold the general theme of app so we can reuse it whenever we want without hardcoding values each time.
- Moved the home screen long widget into a a tree of sub-widgets, refactoration of code, improvement & Edit of UI, fixed the overflow-bottom issue while typing in the text field.
- Moved the scan long widget to a tree of sub-widgets, refactoration of code, improvement & Edit of UI.

## 11:00 - 12:00

- Moved the bottom bar long widget screen to a tree of sub-widgets, refactoration of code.
- Made the bottom bar screen consistent with the bottom bar items in the home screen.
- Moved the messages long widget to a tree of sub-widgets, refactoration of code.

## 2:00 - 3:00

- Moved the profile long widget to a tree of sub-widgets, refactoration of code.
- Moved the chat, about and new post long widgets to a tree of sub-widgets, refactoration of code.
- separated partially Strings, colors, variables to single source of edit for reeuasbility.

## 1:30 - 2:30

- Implemented the main auth screen which generates a private key (with bottom-sheet of success) for the user with his name, and the locale caching of it for future use
- Implemented the auth screen for existent keys with caching as well for future use.
- refactored auth screen to chunks of sub widgets of both screens

## 2:00 - 3:00

- Implemented metadata setting after user creates account (private key).
- implementation of retrieval of that data for profile page.
- More refactoring of the global code.

## 3:00 - 3:00

- Implemented update profile metadata mechanism/UI.

## 2222222

## 8

- Implemented the basic tab for showing the current user posts/notes that shows directly text format of it. will be used for more advanced implementation
- Implemented more consistent way to manage relays websocket to get/send data from/to, will be very easy to implmeent a feature that ket the users manage them manually (adding, removing relays...)

## 9 - 10

- Implemented a global feed page that will be used easily for generating more customized feeds
- Implemented a basic bottom sheet that allow the user to add a new post/note to the relays

## 11

Added file upload method with that is based also on Nostr with nostr.build

## 12 - 13

IMplemented the show of the user's name/username, avatar, and date of the post he created in the post UI.

Implemented the reaction (like) functionality for posts & tested it

## 14 - 15

Implementation of single or multo images select and categories selection when posting and adding a new post to relays.

Improved the UI of the add new post bottom sheet, with error and success handling with snackbars.

## 16

Imlemntation of a comments section screen for each post, not completed yet but the basic functionality is there.

## 17

- global refactoring of the code, fixing some minor bugs in the whole app.

## 18

- Implementation of multiple feeds in addition of the global's for the user homepage, with rebuild fir a simple UI with custom islamic icons...

- Implementation for custom categories selection when adding posts to the targetted feeds.

## 3333333333333333

## 19-20

- Implementation of the UI and partial implementation of the custom advanced search for feeds, containing the search bar, search options, and a date range picker to search for posts in a specific date range.

- refactoring more widgets to be more reusable and more consistent with the app's.

## 21-22

- Implementation of the advanced search feature for feeds, it contains options for:

  - search by user public keys.
  - search by content of posts/notes.
  - search by specific date notations of Nostr date formats.
  - search by specific hashtags.
  - search for posts/notes that includes images.
  - search for posts in a specific date range.
    in addition if a reset button to reset the search options to default automatically.

- refactoring and separation of the code widgets to be more consistent and more reusable.

## 23

- Implementation of note cards methods for:
  - copying the note content.
  - copying the note id.
  - copying the note owner public key.
  - copying the whole serialized note event.

## 24-25

- Implementation of the profile current user's posts/notes screen, which shows the user's posts/notes in a list view with the ability to copy the note content, note id, note owner public key, and the whole serialized note event as well.

- Fixing the major scrolling overflow issue in the profile screen, caused by other nested scroll views.

## 26

- Implemented likes posts tab section in the user profile screen.

## 27

- Implementation of the profile avatar picking up from gallery or from the camera directly, then uploading ir to the nostr.build and setting it up in the profile metadata which will update the user's avatar in the app.
- Implementation the feature of deleting the profile totally for the user profile avatar.
- Implemented the feature of openeing the profile avatar in full screen mode.

## 28

- Implementation of the user's profile options bottom sheet, which allow users to:
  - navigate to the screen for editing the other profile metadata and informations.
  - Copy the user's public key.
  - Copying the user's metadata event.
  - Copying the user's metadata as json string.
  - copying the user's profile avatar url.
  - Copying the user's profile username.

## 29

- Implementation of followings mechanism in the app, which allow users to follow other users.

## 30

- Implementation of the followings feed which will show all the posts/notes of the users that the current user is following.

## 31-32

- Implementation of relays configuration, where a user can:
  - Toggle the relay on/off ti be used or not in the app.
  - Add new relays to the app.
  - Reconnect to relays if the connection is lost or when the relay is added in order to apply changes in the Nostr service.
  - Remove relays from the app.

## 33

- Implementation of tha onboarding skeleton for the app, which will be used to show the user some app's features and advantages and how to use it.

## 34

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

## 35 - 36

- Implementation of a simple profile sheet that give the user the ability to been redirected to euther the authentication with existent key or to create a new key pair.
- Implementation of a search bottom sheet where a user can put a pubKey or a Nostr identifier and expect to see a relevant user (profile) for that pubKey or identifier.
- Added the placeholder sheets for the dark mode switcher and the language switcher.&
- Re-implemented the whole oboarding first screen UI with fancy animations and simple effective UI.

## 37 - 38

- Implementation of dark theme switcher functionality thatswitches the theme of the app between light and dark themes.
- Adding the dark themes aligned to the default light theme.

## 39

- Fixed the issue related to concurrent/repeated events to just drop in feeds, reactions, notes, followings... with a sorting & filtering algorithms.

## 40 - 41

- The add of the dart_code_metrics plugin for the Dart analyzer with a strict bunch of rules.
- Refactoring the while buisness logic folder that contains all the app blocs and cubit, so we ensure 100% free of unexpected behavior such encountring null values, non-caght exception...

## 42

- Migrating screens UI to use the declared themes colors for some screens such as onboarding, auth choose, sign up.. (not all)

## 43

- Applied minor changes for snackbars, bottom sheets, general widgets, alerts.. to either migrate to dark themes or for ensuring responsiveness.
- Migrated more app components to dark themes.

## 44

- Added the option to check for relays information while managing them by a user in the relays manager screen of the authenticated user space.
- Handled the sign up loader to not allow the user to navigate to the home screen until his data exists in the relays, so we can avoid the case where a user might try to sign up quick and get in before his image is laoded and his data is sent successfully to relays.

## 45 - 46

- Implementation of the logout functionality so a user can log out from his account and get back to the onboarding screen whenever he want.
- Added a global screen loader for the app that ensure that all relays web sockets are connected successfully before moving to any other screen that may send/receive relays, so we prevent failures where user will do an action to non-connecting relays that will brash the app.
- migrated to dark themes in more app components.
- Fixed some minors issue related to bottom sheets and snackbar that don't show as expected on some cases.

## 47-48-49

- Implementation of the settings screen that allows to:
  - Get & copy the user's keys including:
    - public key.
    - private key.
    - npub key
    - nsec key.
  - Toggles the app screen
  - A quick navigation action to the relays manager screen.
  - Translations switcher to switch between the app's languages.
  - logout the user from his account.

## 50

- Implementation of the initial UI for the chat experience.

## 51 - 52 - 53

- Setup the OpenAI service inside the app for later use.
- Setup the logic behind the chat experience that will be used to send messages to the OpenAI service and get the response back.. and managing the app state while doing that.
- Setup the translations logic that will be used to translate all the app's strings to the selected language. 

## 54

- Moving default app strings to the en.json file which will be used as the default language for the app (english) and will be used as a fallback language if the selected language is not supported.
- Confirming typos in the app's strings and fixing them.
- reflecting this changes in literally all the app project files and components.

## 55

- Adding more supported languages to the app including: 
  - French
  - Spanish
  - German
  - Italian
  - Portuguese
  - Russian
  - Chinese
- Ensuring that all the app's strings are translated to the supported languages and that the app listens to the selected language and updates the UI accordingly.

## 56

- Editing the drawer menu to include the app logo, to be a mediator between the main screens and other's like settings.
- Applied more of the dark theme to more components and UI in the app where it was missing.

## 57 - 58 - 59 - 60

- Building the chat experience and linking the OpenAI service with the state handler of the app to get a fully working AI chat experience to users.
- Building the instructors screen that will show a modules with separated AI instructions for each one, so it have it's own chat experience.
- Implemented the mechanism behind the pre-set questions for each instructed AI chat that will shows up to the user when he first open the chat in a randomized way.
- Fixed some minor bugs that relates to app state.
## 61  - 62 - 63

- Applied new translations to other languages that was missing.
- Implementation of the youtube video option in the note creation bottom sheet, so the user can show either to upload images or to select and render a youtube video in his note, the implementation includes UI, logic, state management..

## 64

- Implementation of the new notes tooltip that will be shown whenever a new note(s) is added by the user or others in a specific feed, it is clickable and will shows those notes when it is clicked
- added the keys option to the profile bottom sheet, so the user can navigate through the "keys" screen to retrieve and manage his keys.

## 65 - 66

- Implementation of the "keys" page which will show all kind of keys for the user such as:
- public key
- private key
- npub key
- nsec key

## 67

- Changed full image screen to support working with uploaded files from the devices storage and also from links since both use cases exists in the app (when uploading an avatar file, when showing notes images, other users avatars..)

## 68 - 69

- Add of youtube video url ,thumbnail filterers that will detect any youtube video that is included in any note events in order to render it as well in feeds notes and not only in the note creation bottom sheet.
- Made the full image screen to support many images and not only one, so a user can slide between them while he is in full screen mode.
- Applied translations for the new strings to all the supported languages.

## 70

- Added support New Language (turkey).

## 71

- Added option for sorting (A-Z or Z-A) for the advanced notes search for feeds.
- Added new post icon button in the menu as well to show the add new post bottom sheet.
- Added browse button for topics feeds in the home screen, so the user can navigate to the topics feeds screen.
- Refactored, fixed issues, applied new breaking changes for used nostr package in all state management (blocs/cubits) code of the app

## 72 - 73 - 74

- Implementation of the user posts, takes (reposts) sections in profile.
- Added follow/unfollow, copy images links, copy youtube video link in the note card options bottom sheet.
- Implemented the feature to repost a specific note to the user's feed/profile.

## 75

- Fix/Implementation of the user's "edit profile" screen, where he can edit his profile metadata

## 76

- Implementation of the camera feature for users when uploading their avatar image, besides that they can of course take it from gallery.

## 77 - 78

- Applied the required changes in the onboarding flow, such as:
- Requiring the user to copy the private key before going further.
- Removing some steps, and changing order of them.
- Added a bottom sheet that inform users about their account creation success and that they can go to the home screen now and use the app.
- Minor changes for theme, logo.

## 79

- Implementation of relays connection loader screen when an authenticated user closes and come back to the app, so we ensure that all relays are connected before moving to any other screen that may send/receive data from/to relays.

## 80

- Customization for the app launcher icons, logo, name
- Added translations for new strings to all supported languages.
- Application to dynamic themes in parts that miss it.

## 81 - 82 - 83

- Creation of a level based screen for choosing a specific level in the Imam On Duty, that will navigate user to the convenient chat screen for that level.
- Applied more strings and their translations to the app.

## 84

- Moving the note creation action to a custom floating action button that show app differently.
- remove of unnecessary steps in the onboarding flow such as NIP 05 verification and the profiles recommendations by the app.
- Implementation of youtube video urls verification while creating a new note event.

## 85 - 86

- made the required changes to the home page bottom bar sub-pages, such as:
  - Removing the global chat screen.
  - Adding the Ummah screen for showing notes from all categories in it.
  - Changing their order as required.
  - Adding another profile option in the home page menu bar and in the menu.
- modification of the youtube video widget, in addition of supporting the full screen of it.

## 87

- Implementation of the comments feature for each note, including the UI, and login to add and to filter comments note events of it.

## 88

- Applied new strings translations to all other supported languages.
- Applied some of the required changes in feeds page such as:
  - made the tap of a card to move/navigate automatically to the note comments screen.
  - show always initially the Ummah (global feed) screen when the app is opened
  - removing the Shariaa screen/tag from the app at all.

## 89 - 90 - 91

- Implementation of the feature to share a generated AI response from the Imam On Duty directly as a user note event, so users can share it with others in the app, and will be the same as creating a new note, which means they will still be able to upload images, choose tags, or specify a youtube video.
- Added an interactive view (zoom in/out) feature for the images full screen so users can zoom in/out in the images while they are in full screen mode.
- Implementation of a slider indicator for images in full screen mode, so users can know how many images are there and which one they are currently viewing.
- Added the missing bio field in the "edit profile" screen.
- Applied more changes to the ap strings and translations

## 92

- Fixed the issue related to the shown comments in the profile or feeds as user notes, now comments will only be shown in the relevant notes comments section.
- Added the previously removed nip 05 verification screen from onboarding, to a whole separated section in the menu of the app.
- applied the pattern asset as a faded background for all bottom sheets used in the app.

## 93 - 94

- Added privacy & policy as a step of the onboarding flow of the app, including the accept checkbox  and logic so the user will not go further until he accepts it..

## 96-97

- Creation of app screenshots (10), and the cover used in the store listing.
- The writing of the app details such as title, subtitle, description, features...

## 98

- Migrations of some components/widgets to show animations used in the app.
- Addition and translations of newest texts/strings to supported languages.
- Implementation of the account creations success bottom sheet that is shown right when the user finishes creating his account, so he can go to the home of the app.

## 99 - 100

- Implementation of the report feature UI, bottom sheet & logic for notes, so the user can send Nostr report events to used relays, which can be one of the options:
- nudity.
- profanity
- illegal
- spam
-impersonation
- Medium general widgets UI fixes related to sizing which caused some of the unexpected grey screens.
101-102
- Update/Correctness of all the reported texts/strings such as the NIP05's to lightning address, new post bottom sheet...
103
- Changing the Imam On Duty from a stand-alone screen to a bottom sheet that is triggered from the same previous button but shows it instead of opening it in a whole screen.
- Update the Imam On Duty represented icon in the bottom bar.

## 104

- Re-implementation of the assets placeholder inside the new note bottom sheet as requested to make it identifiable by the user, added callbacks to the placeholder itself to show the options of camera & gallery.

## 105

- Separation of the Nostr service used internally in the app by modules/roles for sending new notes for various use-cases in the app and listening to events subscriptions to use them, since its codebase get very large.
106
- Fixed the Imam on Duty text field which was not allowing to preview a long input.
- Minor UI edits such as profile section icon, texts, and Imam On Duty Questions.

## 107-108-109-110

- Coverage of all the app logic blocs with appropriate developer-friendly documentation including their members, methods, and constructors... since the codebase gets large and getting lost is easy when trying to find or remember a single item goal of implementation, also to avoid code conflicts and breaking changes.
- Editing some behaviors related to showing note events such as reverse sorting (from Z-A instead of A-Z).
- Re-organized many modules by their types in separated files to make it more easier to access them such as user Dart's enums, environment variables, services, and extensions...
- Editing some components appearance to have the used app animations.
- Addition/translations of more strings/texts used in previous changes.

## 111

- Add of more convenient questions for intermediate-advanced questions of the Imam On Duty for random hint selection for first message usage by the user.

## 112-113

- Add of loading indicator for the user profile's posts, takes, likes tabs notes, so he knows whether to expect something to show or not.
- More code reactivation and appliance of more SOLID principles.

## 114-115

- Implementation of a profile banner feature to show a banner in the user's profile and be able to manage, delete, change, and add his own from either the device camera or gallery, the app handles the rest internally.
116-117-118-119
- Bug fixes
- disallowed the user to return back to onboarding after getting inside the home of the app
- Applied the new Imam On Duty SVG icon by creating a new widget handler for SVG icons and making them work as others in the bottom bar.

## 120-121-123-124-125 (accumulation of total hours for this task)

- Support the Arabic language by translating all English.
- Implementation of its option in the app for choose.
- Implementation of rtl Alignment for the whole app components when the Arabic lang is chosen.
- Bug fixes and handling unexpected behaviors.

## 126-127

- Addition of more Imam On Duty questions by level.
- Add app animations to more components that need it such as the "about" screen.

## 128-129

- Re-implementation of the note comments feature, re-creating its components to adapt to previous changes.
- Fixing the grey screen showing in some cases
- Fixing the non-scrollable screen when a note is too large.
- Loading of the comment owner metadata to present it such as name & profile.

## 130

- More Bug fixes in the level of some blocs that causes the "StackOverflow" error which caused some lagging in the app.

## 131

- Added caching mechanism for the onboarding search feature.
- optimized the state management of the onboarding search UI by minimizing the area of the bloc consumer to the units that will actually update and be listened to.

## 132

- Implementation of a bottom sheet for showing additional information about a user when pressing on the comment three dots.
- Update of the OpenAI API key to the newly created account for the support@munawarah.engineering email.

## 133

- Re-implementation & optimization of the youtube feature to avoid lagging while scrolling, and wasting internet data of the uncontrolled pre-loading of video buffers that affect the Nostr operation (sending & getting events) success rates and retrievals.
- Support & Bug fixes for a full screen that caused also some lags.
134-135-136
- Addition & translations for all the newly added strings/texts to the app-supported languages from the previous changes.
- Add more copy options for note comments, such as copying the comment itself or its id.

## 137-138

- Fixed & adapted to the new nostr.build implementation so we can use it to upload assets in the app.
(They changed the whole website and endpoints of uploading files, in addition to changing their used domain for assets which is https://cdn.nostr.build now).
- UI error handling for the Imam On Duty, so when there is something wrong, the user will get a message informing that. and not the empty behavior that doesn't inform anything.
- Addition/Translations of more text/strings from the previous changes.

## 139

- Implmentation of the feature to show the latest followings notes in the ummah feed, instead of all Munawarah notes, so now:
  - When a user is not following anyone, all Munawrah notes created b all users will be shown.
  - When a user starts to follow people, they will be added to followings list as expexted that already happen in the app. And from now, there notes will be shown in the ummah feed only.
- Ensured that the text field will be unfocussed forcelly when a user sends a new note by clicking the send button, on the note creation bottom sheet.

## 140

- set the app so it defaults to the dark theme initially and not adapted to the system theme, all new users will use the app in first time with the dark.
- Added pluralization for used strings that represents time, such days(s), hour(s)... and its use in the app.
- Adjusted the opacity of the text field of the note creation bottom sheet.

## 141-142

- Implmentation of profile for all users as well like the current user's, so a user can see other users profiles, their notes, their likes..., but it is not finished, it require more adaption for the user's owned data only so it doesn't conflict with the current user's data.
