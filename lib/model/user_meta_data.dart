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

  /// {@macro user_meta_data}
  const UserMetaData({
    required this.name,
    required this.picture,
    required this.banner,
    required this.username,
    required this.about,
  });

  /// {@macro user_meta_data}
  /// Instantiate a [UserMetaData] from a json.
  factory UserMetaData.fromJson(Map<String, dynamic> json) {
    return UserMetaData(
      name: json['name'] ?? UserMetaData.placeholder().name,
      picture: json['picture'] ?? UserMetaData.placeholder().picture,
      banner: json['banner'] ?? UserMetaData.placeholder().banner,
      username: json['username'] ?? UserMetaData.placeholder().username,
      about: json['about'] ?? UserMetaData.placeholder().about,
    );
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
    return name;
  }

  @override
  List<Object?> get props => [name, picture, banner, username, about];
}
