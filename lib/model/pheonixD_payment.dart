// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

abstract class PhoenixDPayment extends Equatable {
  final String? paymentHash;
  final String? preimage;
  final bool? isPaid;
  final int? fees;
  final String? invoice;
  final int? completedAt;
  final int? createdAt;

  PhoenixDPayment({
    this.paymentHash,
    this.preimage,
    this.invoice,
    this.isPaid,
    this.fees,
    this.completedAt,
    this.createdAt,
  });
}
