enum AppCubitNewRelayPosition {
  top,
  bottom,
}

enum LoadingUserResourcesStatus {
  initial,
  loading,
  success,
  error,
}

enum AppLogoStyle {
  white,
  whiteBig,
  black,
  blackBig,
}

enum KeySectionType {
  privateKey,
  publicKey,
  nPubKey,
  nsecKey,
}

enum HiddenPrivateKeySectionType {
  privateKey,
  nsecKey,
}

// source: https://github.com/nostr-protocol/nips/blob/master/56.md
enum ReportType {
  nudity,
  profanity,
  illegal,
  spam,
  impersonation,
}

enum RoundaboutTopics {
  exampleFeed,
}

enum ImagePickType { banner, avatar }
