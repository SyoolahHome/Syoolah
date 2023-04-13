abstract class AppStrings {
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
}
