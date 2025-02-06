part of 'npub_cash_payment_invoice_cubit.dart';

class NpubCashPaymentInvoiceState extends Equatable {
  const NpubCashPaymentInvoiceState({
    this.paidSuccessfully = true,
  });

  final bool paidSuccessfully;

  @override
  List<Object?> get props => [
        paidSuccessfully,
      ];

  NpubCashPaymentInvoiceState copyWith({
    bool? paidSuccessfully,
  }) {
    return NpubCashPaymentInvoiceState(
      paidSuccessfully: paidSuccessfully ?? this.paidSuccessfully,
    );
  }
}

final class NpubCashPaymentInvoiceInitial extends NpubCashPaymentInvoiceState {}
