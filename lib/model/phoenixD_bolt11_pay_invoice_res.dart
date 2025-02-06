import 'package:equatable/equatable.dart';

class PhoenixDBolt11PayInvoiceResponse extends Equatable {
  final int recipientAmountSat;
  final int routingFeeSat;
  final String paymentId;
  final String paymentHash;
  final String paymentPreimage;

  PhoenixDBolt11PayInvoiceResponse({
    required this.recipientAmountSat,
    required this.routingFeeSat,
    required this.paymentId,
    required this.paymentHash,
    required this.paymentPreimage,
  });

  factory PhoenixDBolt11PayInvoiceResponse.fromMap(Map<String, dynamic> data) {
    return PhoenixDBolt11PayInvoiceResponse(
      paymentHash: data['paymentHash'],
      paymentId: data['paymentId'],
      paymentPreimage: data['paymentPreimage'],
      recipientAmountSat: data['recipientAmountSat'],
      routingFeeSat: data['routingFeeSat'],
    );
  }

  @override
  List<Object?> get props => [
        recipientAmountSat,
        routingFeeSat,
        paymentId,
        paymentHash,
        paymentPreimage,
      ];
}
