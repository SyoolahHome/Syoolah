import 'package:ditto/model/pheonixD_payment.dart';

class PhoenixDOutgoingPayment extends PhoenixDPayment {
  final String? paymentId;
  final int? sent;

  PhoenixDOutgoingPayment({
    this.paymentId,
    this.sent,
    super.completedAt,
    super.fees,
    super.createdAt,
    super.invoice,
    super.isPaid,
    super.paymentHash,
    super.preimage,
  });

  factory PhoenixDOutgoingPayment.fromMap(Map<String, dynamic> data) {
    return PhoenixDOutgoingPayment(
      paymentId: data['paymentId'],
      sent: data['sent'],
      completedAt: data['completedAt'],
      fees: data['fees'],
      createdAt: data['createdAt'],
      invoice: data['invoice'],
      isPaid: data['isPaid'],
      paymentHash: data['paymentHash'],
      preimage: data['preimage'],
    );
  }

  @override
  List<Object?> get props => [
        paymentId,
        sent,
        completedAt,
        fees,
        createdAt,
        invoice,
        isPaid,
        paymentHash,
        preimage,
      ];
}
