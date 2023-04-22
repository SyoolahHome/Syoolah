abstract class AppStrings {
  static const String availableRelays = 'Available relays';
  static const String create = 'Create';
  static const String login = 'Login';
  static const String createNewAcc = 'I am new here!';
  static const String createNewAccDescription =
      'You will be redirected to create a new account and get your keys';
  static const String alreadyHaveAKey = 'I already have a key!';
  static const String alreadyHaveAKeyDescription =
      'You will be redirected to login with your existent key';
  static const String searchUsersHint = 'Ex: bob@example.com';
  static const String identifierOrPuKey = 'Identifier or public key';
  static const String searchUser = 'Search A user';
  static const String aboutMunawarah = "What Munawarah solves?";
  static const String aboutMunawarahWe = "What we solves?";
  static const String appDescrition = "Tons of questions,\nTons of answers";
  static const String getStarted = "Get Started";

  static const String close = 'Close';
  static const String cancel = 'Cancel';
  static const String ok = 'Ok';
  static const String remove = 'Remove';
  static const String reconnect = "Reconnect";
  static const String reconnecting = "Reconnecting...";
  static const String add = "Add";
  static const String relayUrlHint = "wss://relay.damus.io";
  static const String addRelay = 'Add relay';
  static const String addRelayUrlLabel = 'relay web socket url';
  static const String manageRelays = 'Manage your relays configuration';
  static const String openCommentsSections = 'Open comments sections';
  static const String copyNoteEventId = 'Copy note event id';
  static const String copyNoteEvent = 'Copy note event';
  static const String copyNoteContent = 'Copy note content';
  static const String resendToRelays = 'Resend to relays';
  static const String invalidUrl = 'Invalid url';
  static const String BottomSheetOptions = 'Options';
  static const String fullImageView = 'Full image view';
  static const String copyPubKey = 'Copy public key';
  static const String copyMetaDataEvent = 'Copy profile metadata event';
  static const String copyProfileEvent = 'Copy profile event';
  static const String copyImageUrl = 'Copy image url';
  static const String copyUsername = 'Copy username';
  static const String takeFromGallery = 'Choose from gallery';

  static const String takeFromCamera = 'Take from camera';
  static const String removeAvatar = 'Remove avatar';
  static const String changeAvatar = 'Change avatar';
  static const String posts = "posts";
  static const String reposts = "reposts";
  static const String likes = "likes";
  static const String myProfile = "My Profile";
  static const String noImagesToCopy = "No images to copy";
  static const String followings = "Followings";
  static const String followers = "Followers";
  static const String copySuccess = 'Copied to clipboard';
  static const String copyError = 'Error copying to clipboard';
  static const String reset = "Reset";
  static const String pick = "Pick";
  static const String dateRange = "Date Range";
  static const String searchOptions = "Search Options";
  static const String customizeSearch = "Customize Search";
  static const String search = "Search";
  static const String followingsFeed = "Followings Feed";
  static const String followingsFeedDescription =
      "Feed of all the people you follow";
  static const String globalFeedDescription =
      "Feed of all the posts from all the users";
  static const String quran = "Quran";
  static const String dua = "Dua";
  static const String sharia = "Sharia";
  static const String hadith = "Hadith";
  static const String fiqh = "Fiqh";
  static const String sirah = "Sirah";
  static const String feeds = "Feeds";
  static const String categorizedFeeds = "Categorized Feeds";
  static const String globalFeeds = "Global Feeds";
  static const String comments = "Comments";
  static const String follow = "Follow";
  static const String unfollow = "Unfollow";
  static const String error = "Something went wrong, try again";
  static const String postCreatedSuccessfully = "Post Created Successfully";
  static const String selectedImage = "Selected Image";
  static const String chooseCategories = "Choose Categories";
  static const String yourPost = "Your Post";
  static const String createNewPost = "Create New Post";
  static const String addNewPost = "Add New Post";
  static const String globalFeed = "Global Feed";
  static const String globalFeedDescrition = "Global Feed Description";
  static const String appName = 'Munawarah';
  static const String homeTitle = "Hajji";
  static const String writeYourNameHere = "Write your name here..";
  static const String continueText = "Continue";
  static const String privateKeyAccess = "Private Key access";
  static const String yourName = "Your name";
  static const String yourPrivateKey = "Your private key";
  static const String writeYourKey = "paste your key here..";
  static const String scan = "Scan";
  static const String typeHere = "Type here..";
  static const String loading = "loading";
  static const String globalMessages = "Global Messages";
  static const String pleaseEnterName = "Please enter your name";
  static const String start = "Start";
  static const String keyGeneratedSuccessfullyText =
      "Your private key has been generated successfully, you can now start using the app.";
  static const String privateKeyCopied = 'Private key copied to clipboard.';
  static const String pleaseEnterKey = 'Please enter your private key';
  static const String invalidKey = "The key you entered is invalid.";
  static const couldNotCopyKey = "Could not copy key to clipboard.";
  static const editProfile = "Edit Profile";
  static const save = "Save";
  static const aboutMunawarahContent = """
Trust is essential in all endeavors. It's the single most important ingredient in business but spotting it is a rare phenomenon these days that's failing humanity when the world needs it most.

The same is true for religion as millions of brothers and sisters in Islam gather from all over the world to perform Hajj and Umrah when it's all too easy to feel lost in the enormity of it all not knowing who to trust when things go wrong in a sea of humanity pleading for Allah's mercy.
 
You're in the right place if this sounds familiar to you - if you're at a parting stone in your life and you're not sure which path is the right path for you.

You're not alone. The whole world is lined up right behind you struggling with the same issues that the Quran was revealed to solve fourteen hundred years ago.

At Munawarah, we're upgrading trust in Islam with cryptographic keys that make it easy to secure intentions online that start halal and stay halal - forever.

We're building a world that's impossible to hack intentions - a world where intentions aren't determined by how much money you make (or wish you could) but one where total strangers can trust each other without fear of getting scammed for the 1st time since the days of the Prophet (PBUH) when the holy Kabbah once served as a vault to exchange goods between parting caravans.
""";
  static commentsN(int n) {
    return "$comments ($n)";
  }

  static String feedOfName(String name) => "$name's Feed";
  static String removeRelay(String url) {
    return 'Remove relay\n$url?';
  }
}
