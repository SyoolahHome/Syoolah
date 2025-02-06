import 'package:ditto/model/bip353_userename_creation_response.dart';
import 'package:ditto/services/networking/http.dart';

class TwelveCash {
  TwelveCash._();

  static TwelveCash _instance = TwelveCash._();

  static String? baseUrl;

  static TwelveCash get instance {
    if (baseUrl == null) {
      throw Exception("TwelveCash is not initialized");
    }

    return _instance;
  }

  static void setBaseUrl(String baseUrlToUse) async {
    baseUrl = baseUrlToUse;
  }

  Future<Bip353UserenameCreationResponse> createUsername({
    required String domain,
    required String bolt12Offer,
    String? silentPaymentsAddress,
    String? onChain,
  }) async {
    final uri = _buildFullEndpoint("/v2/record");

    final res = await AppHttpClient.post<Bip353UserenameCreationResponse>(
      uri: uri,
      body: {
        "domain": domain,
        "lno": bolt12Offer,
        "onchain": onChain ?? "",
        "sp": silentPaymentsAddress ?? "",
      },
      headers: {
        "Content-Type": "application/json",
      },
      onSuccess: (Map<String, dynamic> data) {
        return Bip353UserenameCreationResponse.fromMap(data);
      },
    );
    return res;
  }

  Uri _buildFullEndpoint(String endpointOnly) {
    final endpointToUSE =
        endpointOnly.startsWith("/") ? endpointOnly : "/$endpointOnly";

    if (baseUrl == null) {
      throw Exception("No base url is used");
    }

    final fullUrl = baseUrl! + endpointToUSE;

    var uri = Uri.parse(fullUrl);

    return uri;
  }
}
