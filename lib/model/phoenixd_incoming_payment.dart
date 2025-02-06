// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:ditto/model/pheonixD_payment.dart';

class PhoenixDIncomingPayment extends PhoenixDPayment {
  final String? externalId;
  final String? description;
  final int? receivedSat;

  PhoenixDIncomingPayment({
    this.externalId,
    this.description,
    this.receivedSat,
    super.paymentHash,
    super.preimage,
    super.invoice,
    super.isPaid,
    super.fees,
    super.completedAt,
    super.createdAt,
  });

  factory PhoenixDIncomingPayment.fromMap(Map<String, dynamic> data) {
    return PhoenixDIncomingPayment(
      paymentHash: data['paymentHash'],
      preimage: data['preimage'],
      externalId: data['externalId'],
      description: data['description'],
      invoice: data['invoice'],
      isPaid: data['isPaid'],
      receivedSat: data['receivedSat'],
      fees: data['fees'],
      completedAt: data['completedAt'],
      createdAt: data['createdAt'],
    );
  }

  @override
  List<Object?> get props => [
        paymentHash,
        preimage,
        externalId,
        description,
        invoice,
        isPaid,
        receivedSat,
        fees,
        completedAt,
        createdAt,
      ];
}
