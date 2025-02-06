import 'package:ditto/model/phoenixD_bolt11_pay_invoice_res.dart';

class PhoenixDLightningAddressOrBip353IdentitiferPayResponse
    extends PhoenixDBolt11PayInvoiceResponse {
  PhoenixDLightningAddressOrBip353IdentitiferPayResponse({
    required super.recipientAmountSat,
    required super.routingFeeSat,
    required super.paymentId,
    required super.paymentHash,
    required super.paymentPreimage,
  });

  factory PhoenixDLightningAddressOrBip353IdentitiferPayResponse.fromMap(
    Map<String, dynamic> data,
  ) {
    return PhoenixDLightningAddressOrBip353IdentitiferPayResponse(
      paymentHash: data['paymentHash'],
      paymentId: data['paymentId'],
      paymentPreimage: data['paymentPreimage'],
      recipientAmountSat: data['recipientAmountSat'],
      routingFeeSat: data['routingFeeSat'],
    );
  }
}
