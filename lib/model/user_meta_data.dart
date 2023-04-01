class UserMetaData {
  final String username;
  final String name;
  final String picture;
  final String banner;
  final String about;

  UserMetaData({
    required this.name,
    required this.picture,
    required this.banner,
    required this.username,
    required this.about,
  });

  factory UserMetaData.fromJson(Map<String, dynamic> json) {
    return UserMetaData(
      name: json['name'] ?? UserMetaData.placeholder().name,
      picture: json['picture'] ?? UserMetaData.placeholder().picture,
      banner: json['banner'] ?? UserMetaData.placeholder().banner,
      username: json['username'] ?? UserMetaData.placeholder().username,
      about: json['about'] ?? UserMetaData.placeholder().about,
    );
  }

  factory UserMetaData.placeholder() {
    return UserMetaData(
      name: "No Name",
      picture: "https://ui-avatars.com/api/?name=Elon+Musk",
      banner: "https://picsum.photos/200/300",
      username: "No Username",
      about: "No About",
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'picture': picture,
      'banner': banner,
      'username': username,
      'about': about,
    };
  }
}
