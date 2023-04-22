// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

/// {@template user_meta_data}
/// This class is responsible for handling the user's metadata.
/// {@endtemplate}
class UserMetaData extends Equatable {
  /// The username of the user
  final String username;

  /// The name of the user
  final String name;

  /// The picture of the user
  final String? picture;

  /// The banner of the user
  final String? banner;

  /// The about of the user
  final String? about;

  final String? displayName;

  /// {@macro user_meta_data}
  const UserMetaData({
    required this.name,
    required this.picture,
    required this.banner,
    required this.username,
    required this.about,
    this.displayName,
  });

  /// {@macro user_meta_data}
  /// Instantiate a [UserMetaData] from a json.
  factory UserMetaData.fromJson(Map<String, dynamic> jsonData) {
    final json = {...jsonData};

    json.forEach((key, value) {
      if (value == "" || value == null) {
        json[key] = null;
      }
    });

    final metadta = UserMetaData(
      name: json['name'] ?? UserMetaData.placeholder().name,
      picture: json['picture'] ?? UserMetaData.placeholder().picture,
      banner: json['banner'] ?? UserMetaData.placeholder().banner,
      username: json['username'] ?? UserMetaData.placeholder().username,
      about: json['about'] ?? UserMetaData.placeholder().about,
      displayName: json['display_name'],
    );

    return metadta;
  }

  /// {@macro user_meta_data}
  /// Instantiate a [UserMetaData] from a placeholder.
  factory UserMetaData.placeholder() {
    return const UserMetaData(
      name: "No Name",
      picture: "https://ui-avatars.com/api/?name=Elon+Musk",
      banner: "https://picsum.photos/200/300",
      username: "No Username",
      about: "No About",
    );
  }

  /// This will return a json representation of the [UserMetaData] that can be sent to the relays.
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'picture': picture,
      'banner': banner,
      'username': username,
      'about': about,
    };
  }

  String nameToShow() {
    if (name.isNotEmpty) {
      return name;
    } else if (username.isNotEmpty) {
      return "@$username";
    } else if (displayName != null) {
      return displayName!;
    } else {
      return "No Name";
    }
  }

  @override
  List<Object?> get props => [name, picture, banner, username, about];

  UserMetaData copyWith({
    String? username,
    String? name,
    String? picture,
    String? banner,
    String? about,
  }) {
    return UserMetaData(
      username: username ?? this.username,
      name: name ?? this.name,
      picture: picture ?? this.picture,
      banner: banner ?? this.banner,
      about: about ?? this.about,
    );
  }
}
