import 'dart:convert';

import 'package:ditto/model/phoenixD_balance_res.dart';
import 'package:ditto/model/phoenixD_bolt11_generation_response.dart';
import 'package:ditto/model/phoenixD_bolt11_pay_invoice_res.dart';
import 'package:ditto/model/phoenixD_bolt12_pay_offeer_res.dart';
import 'package:ditto/model/phoenixD_lightning_address_or_bip353_identitifer_pay_response.dart';
import 'package:ditto/model/phoenixD_node_info.dart';
import 'package:ditto/model/phoenixD_outgoing_payment.dart';
import 'package:ditto/model/phoenixd_incoming_payment.dart';
import 'package:ditto/services/networking/http.dart';

class PhoenixD {
  static String? passwordKey;
  static String? baseUrl;

  PhoenixD._();

  static PhoenixD _instance = PhoenixD._();

  static PhoenixD get instance {
    if (passwordKey == null || baseUrl == null) {
      throw Exception("PhoenixD is not initialized");
    }

    return _instance;
  }

  static void setPasswordKey(String key) {
    passwordKey = key;
  }

  static void setBaseUrl(String baseUrlToUse) {
    baseUrl = baseUrlToUse;
  }

  Future<PhoenixDBolt11GenerationResponse> createBolt11Invoice({
    required String description,
    required int amountInSats,
  }) async {
    final uri = _buildFullEndpoint("/createinvoice");

    final res = await AppHttpClient.post<PhoenixDBolt11GenerationResponse>(
      uri: uri,
      body: {
        'amountSat': amountInSats,
        'description': description.isEmpty ? "Invoice" : description,
      },
      isFormDataBody: true,
      headers: {
        'Authorization': _basicAuth(passwordKey),
        "Content-Type": "application/x-www-form-urlencoded",
      },
      onSuccess: (Map<String, dynamic> data) {
        return PhoenixDBolt11GenerationResponse.fromMap(data);
      },
    );

    return res;
  }

  Future<PhoenixDBolt11PayInvoiceResponse> payBolt11Invoice({
    required String bolt11Invoice,
    required int amountInSats,
  }) async {
    final uri = _buildFullEndpoint("/payinvoice");

    final res = await AppHttpClient.post<PhoenixDBolt11PayInvoiceResponse>(
        uri: uri,
        body: {
          'amountSat': amountInSats,
          'invoice': bolt11Invoice,
        },
        isFormDataBody: true,
        headers: {
          'Authorization': _basicAuth(passwordKey),
          "Content-Type": "application/x-www-form-urlencoded",
        },
        onSuccess: (Map<String, dynamic> data) {
          return PhoenixDBolt11PayInvoiceResponse.fromMap(data);
        });

    return res;
  }

  Future<String> getBolt12Offer() async {
    final uri = _buildFullEndpoint("/getoffer");

    final res = await AppHttpClient.get<String>(
      uri: uri,
      headers: {
        'Authorization': _basicAuth(passwordKey),
        "Content-Type": "application/x-www-form-urlencoded",
      },
      jsonDecodedResponse: false,
      onSuccess: (dynamic data) {
        if (data is String) {
          return data;
        } else {
          throw Exception("Failed to get bolt12 offer");
        }
      },
    );

    return res;
  }

  Future<PhoenixDBolt12PayOfferResponse> payBol12Offer({
    required String bolt12Offer,
    required int amountInSats,
    required String message,
  }) async {
    final uri = _buildFullEndpoint("/payoffer");

    final res = await AppHttpClient.post<PhoenixDBolt12PayOfferResponse>(
      uri: uri,
      body: {
        'amountSat': amountInSats,
        'offer': bolt12Offer,
        'message': message.isEmpty ? "Payment" : message,
      },
      isFormDataBody: true,
      headers: {
        'Authorization': _basicAuth(passwordKey),
        "Content-Type": "application/x-www-form-urlencoded",
      },
      onSuccess: (Map<String, dynamic> data) {
        return PhoenixDBolt12PayOfferResponse.fromMap(data);
      },
    );

    return res;
  }

  Future<PhoenixDLightningAddressOrBip353IdentitiferPayResponse>
      payLightningAddressOrBip353Identifier({
    required String message,
    required int amountInSats,
    required String address,
  }) async {
    final uri = _buildFullEndpoint("/paylnaddress");

    final res = await AppHttpClient.post<
        PhoenixDLightningAddressOrBip353IdentitiferPayResponse>(
      uri: uri,
      body: {
        'amountSat': amountInSats,
        'address': address,
        'message': message.isEmpty ? "Payment" : message,
      },
      isFormDataBody: true,
      headers: {
        'Authorization': _basicAuth(passwordKey),
        "Content-Type": "application/x-www-form-urlencoded",
      },
      onSuccess: (Map<String, dynamic> data) {
        return PhoenixDLightningAddressOrBip353IdentitiferPayResponse.fromMap(
          data,
        );
      },
    );

    return res;
  }

  Future<String> sendOnChain({
    required String address,
    required int amountInSats,
    required int feeRateSatByte,
  }) async {
    final uri = _buildFullEndpoint(
      "/sendtoaddress",
    );

    final res = await AppHttpClient.post<String>(
      uri: uri,
      headers: {
        'Authorization': _basicAuth(passwordKey),
        "Content-Type": "application/x-www-form-urlencoded",
      },
      body: {
        'address': address,
        'amountSat': amountInSats,
        'feeRateSatByte': feeRateSatByte,
      },
      onSuccess: (dynamic data) {
        if (data is String) {
          return data;
        } else {
          throw Exception("Failed to send onchain");
        }
      },
    );

    return res;
  }

  Future<List<PhoenixDIncomingPayment>> incomingPayments({
    int? from,
    int? to,
    int? limit,
    int? offset,
    bool? all,
    String? externalId,
  }) async {
    final uri = _buildFullEndpoint(
      "/payments/incoming",
      queryParameters: {
        if (from != null) 'from': from,
        if (to != null) 'to': to,
        if (limit != null) 'limit': limit,
        if (offset != null) 'offset': offset,
        if (all != null) 'all': all,
        if (externalId != null) 'externalId': externalId,
      },
    );

    final res = await AppHttpClient.get<List<PhoenixDIncomingPayment>>(
      uri: uri,
      headers: {
        'Authorization': _basicAuth(passwordKey),
        "Content-Type": "application/x-www-form-urlencoded",
      },
      onSuccess: (dynamic data) {
        if (data is List) {
          final List<dynamic> payments = data;

          final parsed =
              payments.map((e) => PhoenixDIncomingPayment.fromMap(e)).toList();

          return parsed;
        } else {
          throw Exception("Failed to get incoming payments");
        }
      },
    );

    return res;
  }

  Future<PhoenixDIncomingPayment> oneIncomingPayment(
    String paymentIdentifier,
  ) async {
    final uri = _buildFullEndpoint('/payments/incoming/' + paymentIdentifier);

    final res = await AppHttpClient.get<PhoenixDIncomingPayment>(
      uri: uri,
      headers: {
        'Authorization': _basicAuth(passwordKey),
        "Content-Type": "application/x-www-form-urlencoded",
      },
      onSuccess: (dynamic data) {
        return PhoenixDIncomingPayment.fromMap(data);
      },
    );

    return res;
  }

  Future<List<PhoenixDOutgoingPayment>> outgoingPayments({
    int? from,
    int? to,
    int? limit,
    int? offset,
    bool? all,
  }) async {
    final uri = _buildFullEndpoint(
      "/payments/outgoing",
      queryParameters: {
        if (from != null) 'from': from,
        if (to != null) 'to': to,
        if (limit != null) 'limit': limit,
        if (offset != null) 'offset': offset,
        if (all != null) 'all': all,
      },
    );

    final res = await AppHttpClient.get<List<PhoenixDOutgoingPayment>>(
      uri: uri,
      headers: {
        'Authorization': _basicAuth(passwordKey),
        "Content-Type": "application/x-www-form-urlencoded",
      },
      onSuccess: (dynamic data) {
        if (data is List) {
          final List<dynamic> payments = data;

          final parsed =
              payments.map((e) => PhoenixDOutgoingPayment.fromMap(e)).toList();

          return parsed;
        } else {
          throw Exception("Failed to get incoming payments");
        }
      },
    );

    return res;
  }

  Future<PhoenixDOutgoingPayment> oneOutgoingPayment(
    String paymentIdentifier,
  ) async {
    final uri = _buildFullEndpoint('/payments/outgoing/' + paymentIdentifier);

    final res = await AppHttpClient.get<PhoenixDOutgoingPayment>(
      uri: uri,
      headers: {
        'Authorization': _basicAuth(passwordKey),
        "Content-Type": "application/x-www-form-urlencoded",
      },
      onSuccess: (dynamic data) {
        return PhoenixDOutgoingPayment.fromMap(data);
      },
    );

    return res;
  }

  Future<PhoenixDBalanceResponse> getBalance() async {
    final uri = _buildFullEndpoint("/getbalance");

    final res = await AppHttpClient.get<PhoenixDBalanceResponse>(
      uri: uri,
      headers: {
        'Authorization': _basicAuth(passwordKey),
        "Content-Type": "application/x-www-form-urlencoded",
      },
      onSuccess: (dynamic data) {
        return PhoenixDBalanceResponse.fromMap(data);
      },
    );

    return res;
  }

  Future<PhoenixDNodeInfo> getNodeInfo() async {
    final uri = _buildFullEndpoint("/getinfo");

    final res = await AppHttpClient.get<PhoenixDNodeInfo>(
      uri: uri,
      headers: {
        'Authorization': _basicAuth(passwordKey),
      },
      onSuccess: (dynamic data) {
        return PhoenixDNodeInfo.fromMap(data);
      },
    );

    return res;
  }

  Uri _buildFullEndpoint(
    String endpointOnly, {
    Map<String, dynamic>? queryParameters,
  }) {
    final endpointToUSE =
        endpointOnly.startsWith("/") ? endpointOnly : "/$endpointOnly";

    if (baseUrl == null) {
      throw Exception("No base url is used");
    }

    final fullUrl = baseUrl! + endpointToUSE;

    var uri = Uri.parse(fullUrl);

    if (queryParameters != null && queryParameters.isNotEmpty) {
      uri = uri.replace(
        queryParameters: queryParameters.map(
          (key, value) {
            return MapEntry(
              key,
              value.toString(),
            );
          },
        ),
      );
    }

    return uri;
  }

  String _basicAuth(String? passwordKey) {
    if (passwordKey == null) {
      throw Exception("No password key is set");
    }

    final bytes = utf8.encode(":" + passwordKey);
    final base64Str = base64.encode(bytes);

    return "Basic $base64Str";
  }
}
