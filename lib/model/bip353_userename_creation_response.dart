import 'package:equatable/equatable.dart';

class Bip353UserenameCreationResponse extends Equatable {
  final String message;
  final String bip353;

  Bip353UserenameCreationResponse({
    required this.message,
    required this.bip353,
  });

  factory Bip353UserenameCreationResponse.fromMap(Map<String, dynamic> data) {
    return Bip353UserenameCreationResponse(
      bip353: data['bip353'],
      message: data['message'],
    );
  }

  @override
  List<Object?> get props => [
        message,
        bip353,
      ];
}
