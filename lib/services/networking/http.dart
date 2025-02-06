import 'dart:convert';

import 'package:ditto/model/phoenixD_bolt11_generation_response.dart';
import 'package:ditto/services/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

abstract final class AppHttpClient {
  static Future<T> post<T>({
    required Uri uri,
    Map<String, dynamic>? body,
    required Map<String, String> headers,
    required T Function(
      Map<String, dynamic> data,
    ) onSuccess,
    bool isFormDataBody = false,
  }) async {
    try {
      dynamic maybeParsedData;
      bool isHttpStatusCodeOk = false;

      if (isFormDataBody) {
        final request = http.Request("POST", uri);

        request.headers.addAll(headers);

        if (body != null) {
          request.bodyFields = body.map(
            (key, value) => MapEntry(key, value.toString()),
          );
        }

        final rawRes = await request.send();

        final rawResBody = await rawRes.stream.bytesToString();

        maybeParsedData = await _maybeJsonDecode(rawResBody);
        isHttpStatusCodeOk = rawRes.statusCode.isHttpStatusCodeOk;
      } else {
        final rawRes = await http.post(
          uri,
          headers: headers,
          body: body != null ? jsonEncode(body) : null,
        );

        maybeParsedData = await _maybeJsonDecode(rawRes.body);
        isHttpStatusCodeOk = rawRes.statusCode.isHttpStatusCodeOk;
      }

      if (maybeParsedData != null && isHttpStatusCodeOk) {
        return onSuccess(maybeParsedData);
      } else {
        throw Exception("Failed to post");
      }
    } catch (e) {
      debugPrint(e.toString());

      rethrow;
    }
  }

  static Future<T> get<T>({
    required Uri uri,
    required Map<String, String> headers,
    required T Function(dynamic data) onSuccess,
    bool jsonDecodedResponse = true,
  }) async {
    try {
      final rawRes = await http.get(
        uri,
        headers: headers,
      );

      final maybeParsedData = jsonDecodedResponse
          ? await _maybeJsonDecode(
              rawRes.body,
            )
          : rawRes.body;

      if (maybeParsedData != null && rawRes.statusCode.isHttpStatusCodeOk) {
        return onSuccess(maybeParsedData);
      } else {
        throw Exception("Failed to get");
      }
    } catch (e) {
      debugPrint(e.toString());

      rethrow;
    }
  }

  static dynamic _maybeJsonDecode(String source) {
    try {
      final forceParseData = jsonDecode(source);

      return forceParseData;
    } catch (e) {
      debugPrint("Couldn't parse json: $e");

      return null;
    }
  }
}
