import 'package:equatable/equatable.dart';

class PhoenixDBolt11GenerationResponse extends Equatable {
  final int amountSat;
  final String serialized;
  final String paymentHash;

  PhoenixDBolt11GenerationResponse({
    required this.amountSat,
    required this.serialized,
    required this.paymentHash,
  });

  factory PhoenixDBolt11GenerationResponse.fromMap(Map<String, dynamic> data) {
    return PhoenixDBolt11GenerationResponse(
      amountSat: data["amountSat"],
      paymentHash: data["paymentHash"],
      serialized: data["serialized"],
    );
  }

  @override
  List<Object?> get props => [
        amountSat,
        serialized,
        paymentHash,
      ];
}
