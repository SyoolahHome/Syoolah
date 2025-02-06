import 'package:ditto/model/phoenixD_bolt11_pay_invoice_res.dart';


class PhoenixDBolt12PayOfferResponse extends PhoenixDBolt11PayInvoiceResponse {
  PhoenixDBolt12PayOfferResponse({
    required super.recipientAmountSat,
    required super.routingFeeSat,
    required super.paymentId,
    required super.paymentHash,
    required super.paymentPreimage,
  });

  factory PhoenixDBolt12PayOfferResponse.fromMap(Map<String, dynamic> data) {
    return PhoenixDBolt12PayOfferResponse(
      recipientAmountSat: data["recipientAmountSat"],
      routingFeeSat: data["routingFeeSat"],
      paymentId: data["paymentId"],
      paymentHash: data["paymentHash"],
      paymentPreimage: data["paymentPreimage"],
    );
  }
}
