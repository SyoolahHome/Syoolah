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

enum WalletV2HistoryPaymentsType {
  incoming,
  outgoing,
}

abstract class EnumWithTitleGetter {
  String get title;
}

enum WalletV2WithdrawType implements EnumWithTitleGetter {
  qrCodeCameraScan,
  formInput;

  @override
  String get title {
    switch (this) {
      case WalletV2WithdrawType.qrCodeCameraScan:
        return "Scan QR Code With Camera";
      case WalletV2WithdrawType.formInput:
        return "Manual Input";
    }
  }
}

enum WalletV2DepositType implements EnumWithTitleGetter {
  createInvoiceWithBol11,
  showReusableBolt12OfferOrBip353Identifier;

  @override
  String get title {
    switch (this) {
      case WalletV2DepositType.createInvoiceWithBol11:
        return "Create New Invoice";
      case WalletV2DepositType.showReusableBolt12OfferOrBip353Identifier:
        return "Reusable QR Code";
    }
  }
}
