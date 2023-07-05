import 'package:equatable/equatable.dart';

/// {@template user_meta_data}
/// This class is responsible for handling the user's metadata.
/// {@endtemplate}
class UserMetaData extends Equatable {
  /// The username of the user.
  final String username;

  /// The name of the user.
  final String name;

  /// The picture of the user.
  final String? picture;

  /// The banner of the user.
  final String? banner;

  /// The about of the user.
  final String? about;

  /// The display name of the user.
  final String? displayName;

  /// The nip05 identifier of the user.
  final String? nip05Identifier;

  final DateTime? userCreatedAt;
  @override
  List<Object?> get props => [
        name,
        picture,
        banner,
        username,
        about,
        displayName,
        nip05Identifier,
        userCreatedAt,
      ];

  /// {@macro user_meta_data}
  const UserMetaData({
    required this.name,
    required this.picture,
    required this.banner,
    required this.username,
    required this.about,
    this.displayName,
    this.nip05Identifier,
    this.userCreatedAt,
  });

  /// {@macro user_meta_data}
  /// Instantiate a [UserMetaData] from a json.
  factory UserMetaData.fromJson(Map<String, dynamic> jsonData) {
    final json = {...jsonData};

    json.forEach((key, value) {
      if (
          // value == ""
          // ||
          value == null) {
        json[key] = null;
      }
    });

    final placeholderMetadata =
        UserMetaData.placeholder(name: json['name'] as String? ?? "No Name");
    return UserMetaData(
      name: json['name'] as String? ?? placeholderMetadata.name,
      picture: json['picture'] as String? ?? placeholderMetadata.picture,
      banner: json['banner'] as String? /* ?? placeholderMetadata.banner */,
      username: json['username'] as String? ?? placeholderMetadata.username,
      about: json['about'] as String? ?? placeholderMetadata.about,
      displayName: json['display_name'] as String?,
      nip05Identifier: json['nip05'] as String?,
      userCreatedAt: json['creationDate'] != null
          ? DateTime.parse(json['creationDate'])
          : null,
    );
  }

  /// {@macro user_meta_data}
  /// Instantiate a [UserMetaData] from a placeholder.
  factory UserMetaData.placeholder({required String name}) {
    return UserMetaData(
      name: "No Name",
      picture: "https://ui-avatars.com/api/?name=$name",
      banner: "https://picsum.photos/200/300",
      username: "No Username",
      about: "No About",
      displayName: "No Display Name",
      nip05Identifier: "No NIP05 Identifier",
    );
  }

  /// This will return a json representation of the [UserMetaData] that can be sent to the relays.
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "creationDate": DateTime.now().toIso8601String(),
      "picture": picture,
      "banner": banner,
      "about": about,
      "username": username.replaceAll("@", ""),
      "nip05": nip05Identifier,
    };
  }

  String nameToShow() {
    if (name.isNotEmpty) {
      return name;
    } else if (username.isNotEmpty) {
      return "@$username";
    } else if (displayName != null) {
      return displayName ?? "No Name";
    } else {
      return "No Name";
    }
  }

  UserMetaData copyWith({
    String? username,
    String? name,
    String? picture,
    String? banner,
    String? about,
    String? displayName,
    String? nip05Identifier,
    DateTime? userCreatedAt,
  }) {
    return UserMetaData(
      name: name ?? this.name,
      picture: picture ?? this.picture,
      banner: banner ?? this.banner,
      username: username ?? this.username,
      about: about ?? this.about,
      nip05Identifier: nip05Identifier ?? this.nip05Identifier,
      displayName: displayName ?? this.displayName,
      userCreatedAt: userCreatedAt ?? this.userCreatedAt,
    );
  }
}
