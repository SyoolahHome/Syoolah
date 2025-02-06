import 'package:equatable/equatable.dart';

class ECashUserInfo extends Equatable {
  final String? username;
  final String? npub;
  final String? mintUrl;

  const ECashUserInfo({
    this.username,
    this.npub,
    this.mintUrl,
  });

  static ECashUserInfo fromMap(Map<String, dynamic> map) {
    return ECashUserInfo(
      username: map['username'] as String?,
      npub: map['npub'] as String?,
      mintUrl: map['mintUrl'] as String?,
    );
  }

  @override
  List<Object?> get props => [
        username,
        npub,
        mintUrl,
      ];

  ECashUserInfo copyWith({
    String? username,
    String? npub,
    String? mintUrl,
  }) {
    return ECashUserInfo(
      username: username ?? this.username,
      npub: npub ?? this.npub,
      mintUrl: mintUrl ?? this.mintUrl,
    );
  }
}
