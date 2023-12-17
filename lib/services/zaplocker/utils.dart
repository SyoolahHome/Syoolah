import 'dart:convert';
import 'dart:typed_data';
import 'package:dart_nostr/dart_nostr.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ZapLockerReflectedUtils {
  final String server;

  ZapLockerReflectedUtils(this.server);

  List<int> hexToBytes(String a) {
    final length = a.length ~/ 2;
    return List.generate(length,
        (index) => int.parse(a.substring(2 * index, 2 * index + 2), radix: 16));
  }

  bytesToHex(List<int> bytes) {
    final hexString =
        bytes.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join('');

    return '$hexString';
  }

  textTohex(String text) {
    final bytes = utf8.encode(text);
    final hex = bytesToHex(bytes);

    return hex;
  }

  Future<bool> isUsernameGood(String username) async {
    final url = Uri.parse(server + 'test_username/?username=${username}');

    final res = await http.get(url);
    return !res.body.toLowerCase().contains("error");
  }

  bool isValidNpub(String npub) {
    try {
      final pubKey = Nostr.instance.keysService.decodeNpubKeyToPublicKey(npub);
      return pubKey.length == 64 && isValidHex(pubKey);
    } catch (e) {
      debugPrint(e.toString());

      return false;
    }
  }

  bool isValidHex(String hex) {
    return true;
  }

  Future<int> getBlockheight(String network) async {
    final uri = Uri.parse(
      "https://blockstream.info/" + network + "api/blocks/tip/height",
    );

    final res = await http.get(uri);

    return int.parse(res.body);
  }

  Future generateHtlc({
    required String serverPubkey,
    required String userPubkey,
    required String pmthash,
    required int timelock,
  }) async {
    final uri = Uri.parse(
      server +
          "generate_htlc/?serverPubkey=${serverPubkey}&userPubkey=${userPubkey}&pmthash=${pmthash}&timelock=${timelock}",
    );

    final res = await http.get(uri);

    return res.body;
  }

  Future<bool> addressOnceHadMoney(String address) async {
    try {
      var response = await http
          .get(Uri.parse('https://mempool.space/api/address/$address'));

      if (response.statusCode > 199 && response.statusCode < 300) {
        final jsonData = json.decode(response.body);

        if (jsonData["chain_stats"]["funded_txo_count"] > 0 ||
            jsonData["mempool_stats"]["funded_txo_count"] > 0) {
          return true;
        }

        return false;
      }

      return false;
    } catch (error) {
      throw Exception('Failed to fetch data: $error');
    }
  }

  Future<bool> waitForMoneyToArriveInAddress(String address) async {
    //
    Future<bool> isAddressFundedYet(String address) async {
      bool addressReceivedMoney = await addressOnceHadMoney(address);

      if (!addressReceivedMoney) {
        await Future.delayed(Duration(seconds: 5));
        return await isAddressFundedYet(address);
      } else {
        return addressReceivedMoney;
      }
    }

    Future<bool> getTimeoutData() async {
      return await isAddressFundedYet(address);
    }

    return await getTimeoutData();
  }

  Future<List<dynamic>> addressReceivedMoneyInThisTx(String address) async {
    try {
      var response = await http
          .get(Uri.parse('https://mempool.space/api/address/$address/txs'));

      if (response.statusCode == 200) {
        var jsonData = json.decode(response.body) as List;

        late String txid;
        late int vout;
        late double amt;

        jsonData.forEach((tx) {
          (tx["vout"] as List).forEach((output) {
            if (output["scriptpubkey_address"] == address) {
              txid = tx["txid"];
              vout = output["n"];
              amt = output["value"]?.toDouble() ?? 0.0;
            }
          });
        });

        return [txid, vout, amt];
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (error) {
      throw Exception('Failed to fetch data: $error');
    }
  }

  Future<String> getMinFeeRate() async {
    try {
      var response = await http
          .get(Uri.parse('https://mempool.space/api/v1/fees/recommended'));

      if (response.statusCode == 200) {
        var fees = json.decode(response.body);
        if (!fees.containsKey("hourFee")) {
          return "error -- site down";
        }
        var minFee = fees["hourFee"].toString();
        return minFee;
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (error) {
      throw Exception('Failed to fetch data: $error');
    }
  }

  Future<String> pushBTCpmt(String rawtx) async {
    try {
      var response = await http.post(
        Uri.parse('https://mempool.space/api/tx'),
        body: rawtx,
        // headers: {'Content-Type': 'text/plain'}, // Set appropriate headers
      );

      if (response.statusCode == 200) {
        var txid = json.decode(response.body);

        return txid;
      } else {
        throw Exception('Failed to push transaction: ${response.statusCode}');
      }
    } catch (error) {
      throw Exception('Failed to push transaction: $error');
    }
  }

  List<T> removeDuplicates<T>(List<T> arr) {
    var unique = arr.toSet().toList();

    return unique;
  }

  Future<bool> isValidAddress(String address) async {
    final uri = Uri.parse(server + "isValidAddress/?address=${address}");

    try {
      final res = await http.get(uri);

      if (res.statusCode == 200) {
        final jsonData = json.decode(res.body) as Map<String, dynamic>;

        return jsonData["isValidAddress"] == true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<String> sweepingHTLC({
    required txid,
    required txindex,
    required original_quantity_of_sats,
    required new_quantity_of_sats,
    required userPrivkey,
    required serverPubkey,
    required preimage,
    required timelock,
    required useraddress,
    required userPubkey,
  }) async {
    final uri = Uri.parse(
      server +
          "sweepingHTLC/?txid=${txid}&txindex=${txindex}&original_quantity_of_sats=${original_quantity_of_sats}&new_quantity_of_sats=${new_quantity_of_sats}&userPrivkey=${userPrivkey}&serverPubkey=${serverPubkey}&preimage=${preimage}&timelock=${timelock}&useraddress=${useraddress}&userPubkey=${userPubkey}",
    );

    try {
      final res = await http.get(uri);

      if (res.statusCode == 200) {
        return res.body;
      } else {
        throw Exception('Failed to sweep HTLC: ${res.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to sweep HTLC: $e');
    }
  }

  Future<Map<String, dynamic>?> getUserData(String userPublickKey) async {
    try {
      final uri = Uri.parse(
        server + "test_pubkey/?pubkey=$userPublickKey",
      );

      final res = await http.get(uri);
      if (res.body.toLowerCase().contains("error: ")) {
        return null;
      }

      final jsonData = jsonDecode(res.body) as Map<String, dynamic>;

      return jsonData;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<bool> verifyrelays({
    required List relays,
    required String signature,
    required String publicKey,
  }) async {
    try {
      final encodedRelays = jsonEncode(relays);
      final uri = Uri.parse(
        server +
            "verifyrelays/?encodedRelays=$encodedRelays&signature=$signature&publicKey=$publicKey",
      );

      final res = await http.get(uri);

      if (res.statusCode == 200) {
        final jsonData = jsonDecode(res.body) as Map<String, dynamic>;

        return jsonData["verifyrelays"] == true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<Map<String, dynamic>> p2wsh({required witnessScript}) async {
    throw UnimplementedError();
  }

  startSwap({
    required String swapPubKey,
    required String address,
    required String pmtHash,
  }) async {
    try {
      final uri = Uri.parse(
        server +
            "/start_swap/?swap_pubkey=${swapPubKey}&htlc_address=${address}&pmthash=${pmtHash}",
      );

      final res = await http.get(uri);

      if (res.statusCode == 200) {
        final jsonData = jsonDecode(res.body) as Map<String, dynamic>;

        return jsonData;
      } else {
        throw Exception('Failed to start swap: ${res.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to start swap: $e');
    }
  }
}
