import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tangem_sdk/tangem_sdk.dart';

class TangemAuth extends StatefulWidget {
  const TangemAuth({super.key});

  @override
  State<TangemAuth> createState() => _TangemAuthState();
}

class _TangemAuthState extends State<TangemAuth> {
  final _jsonEncoder = JsonEncoder.withIndent('  ');

  static const int ID_UNDEFINED = -1;
  static const int ID_SCAN = 1;
  static const int ID_CREATE_WALLET = 2;
  static const int ID_PURGE_WALLET = 3;

  late TangemSdk _sdk;
  int _methodId = 10;

  String? _cardId;
  String? _walletPublicKey;
  String? _scanImage;
  String _response = "";

  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    _sdk = TangemSdk();
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Remix Icons Example'),
        ),
        body: Center(
          child: TextButton(
            onPressed: () async {
              try {
                final res = await _sdk.runJSONRPCRequest(
                  <String, dynamic>{
                    "JSONRPCRequest": jsonEncode(
                      <String, dynamic>{
                        "method": "scan",
                        "params": {},
                        "id": 1,
                        "jsonrpc": "2.0",
                      },
                    ),
                    // "accessCode": null,
                    // "initialMessage": null,
                    // "cardId": null,
                  },
                );
                print(res);
              } catch (e) {
                print(e);
              }
              // _handleScanCard();
            },
            child: Text("scan"),
          ),
        ),
      ),
    );
  }

  void _handleScanCard() {
    _execJsonRPCRequest(_makeJsonRpc(SdkMethod.scan));
  }

  void _handleSign() {
    if (_cardId == null || _walletPublicKey == null) {
      _notify("Scan the card or create a wallet");
      return;
    }

    final request = _makeJsonRpc(SdkMethod.sign_hash, {
      "walletPublicKey": _walletPublicKey,
      "hash":
          "f1642bb080e1f320924dde7238c1c5f8f1642bb080e1f320924dde7238c1c5f8ff",
    });
    _execJsonRPCRequest(request, _cardId);
  }

  void _handleSetScanImage() {
    //
    // _sdk.setScanImage(ScanTagImage(base64Image, 0)).then((value) {
    //   _parseResponse(value);
    //   _printResponse(value);
    // }).onError((error, stackTrace) {
    //   _printResponse(error);
    // });
  }

  void _handleRemoveScanImage() {
    _sdk.setScanImage(null).then((value) {
      _parseResponse(value);
      _printResponse(value);
    }).onError((error, stackTrace) {
      _printResponse(error);
    });
  }

  void _handleCreateWallet() {
    if (_cardId == null) {
      _notify("Scan the card");
      return;
    }

    final request = _makeJsonRpc(SdkMethod.create_wallet, {
      "curve": "Secp256k1",
    });
    _execJsonRPCRequest(request, _cardId);
  }

  void _handlePurgeWallet() {
    if (_cardId == null || _walletPublicKey == null) {
      _notify("Scan the card or create a wallet");
      return;
    }

    final request = _makeJsonRpc(SdkMethod.purge_wallet, {
      "walletPublicKey": _walletPublicKey,
    });
    _execJsonRPCRequest(request, _cardId);
  }

  void _handleSetAccessCode() {
    if (_cardId == null) {
      _notify("Scan the card");
      return;
    }

    final request = _makeJsonRpc(SdkMethod.set_accesscode, {
      "accessCode": "ABCDEFGH",
    });
    _execJsonRPCRequest(request, _cardId);
  }

  void _handleSetPasscode() {
    if (_cardId == null) {
      _notify("Scan the card");
      return;
    }

    final request = _makeJsonRpc(SdkMethod.set_passcode, {
      "passcode": "ABCDEFGH",
    });
    _execJsonRPCRequest(request, _cardId);
  }

  void _handleJsonRpc(String text) {
    try {
      final jsonMap = jsonDecode(text.trim());
      final request = JSONRPCRequest.fromJson(jsonMap);
      _execJsonRPCRequest(request, _cardId);
    } catch (ex) {
      _notify(ex.toString());
    }
  }

  void _execJsonRPCRequest(JSONRPCRequest request,
      [String? cardId, Message? message, String? accessCode]) {
    final completeRequest = {
      "JSONRPCRequest": jsonEncode(request),
      "cardId": cardId,
      "initialMessage": message?.toJson(),
      "accessCode": accessCode,
    };

    _sdk.runJSONRPCRequest(completeRequest).then((value) {
      debugPrint((jsonDecode(value) as Map<String, dynamic>).toString());

      _parseResponse(value);
      _printResponse(value);
    }).onError((error, stackTrace) {
      _printResponse(error);
    });
  }

  void _printResponse(Object? decodedResponse) {
    if (decodedResponse == null) return;

    setState(() {
      _response = _reEncode(decodedResponse);
    });
  }

  void _parseResponse(String response) {
    JSONRPCResponse jsonRpcResponse;
    try {
      jsonRpcResponse = JSONRPCResponse.fromJson(jsonDecode(response));
    } catch (ex) {
      print(ex.toString());
      return;
    }

    if (jsonRpcResponse.result != null) {
      switch (jsonRpcResponse.id) {
        case ID_SCAN:
          {
            _cardId = jsonRpcResponse.result["cardId"];
            final wallets = jsonRpcResponse.result["wallets"];
            if (wallets is List && wallets.isNotEmpty) {
              _walletPublicKey = wallets[0]["publicKey"];
            }
            break;
          }
        case ID_CREATE_WALLET:
          {
            _walletPublicKey = jsonRpcResponse.result["wallet"]["publicKey"];
            break;
          }
        case ID_PURGE_WALLET:
          {
            _walletPublicKey = null;
            break;
          }
      }
    }
  }

  JSONRPCRequest _makeJsonRpc(SdkMethod method,
      [Map<String, dynamic> params = const {}]) {
    return JSONRPCRequest(describeEnum(method), params, _getMethodId(method));
  }

  int _getMethodId(SdkMethod method) {
    switch (method) {
      case SdkMethod.scan:
        return ID_SCAN;
      case SdkMethod.create_wallet:
        return ID_CREATE_WALLET;
      case SdkMethod.purge_wallet:
        return ID_PURGE_WALLET;
      default:
        return _methodId++;
    }
  }

  void _notify(String message) {
    setState(() {
      _response = message;
    });
  }

  String _reEncode(Object value) {
    if (value is String) {
      return _jsonEncoder.convert(jsonDecode(value));
    } else {
      return _jsonEncoder.convert(value);
    }
  }
// describeEnum
}

enum SdkMethod {
  scan,
  sign_hash,
  sign_hashes,
  create_wallet,
  purge_wallet,
  set_accesscode,
  set_passcode,
  reset_usercodes,
  preflight_read,
  change_file_settings,
  delete_files,
  read_files,
  write_files,
}
