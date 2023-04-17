abstract class AppStrings {
  static const String close = 'Close';
  static const String cancel = 'Cancel';
  static const String ok = 'Ok';
  static const remove = 'Remove';
  static const reconnect = "Reconnect";
  static const reconnecting = "Reconnecting...";
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
  static const String appName = 'Application Name';
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

  static commentsN(int n) {
    return "$comments ($n)";
  }

  static String feedOfName(String name) => "$name's Feed";
  static String removeRelay(String url) {
    return 'Remove relay\n$url?';
  }
}
