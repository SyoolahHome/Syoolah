import 'dart:io';
import 'package:crypto/crypto.dart' as crypto;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;

/// {@template tribly_uploader}
abstract class Uploader {
  /// The main endpoint to send the file to.
  String get endpoint;

  /// The main method to upload the file.
  Future<String?> upload({
    required XFile file,
  });

  /// The main method to upload the file.
  XFile? file;
}

class FileUpload {
  /// The list of uploaders that are used to upload files.
  final uploaders = <Uploader>[
    VoidCatUploader(),
    NostrImgUploader(),
    NostrBuildUploader(),
  ];

  Future<String> call(XFile file) async {
    for (final uploader in uploaders) {
      final imageUrl = await uploader.upload(file: file);

      if (imageUrl != null) {
        return imageUrl;
      }
    }

    throw Exception(
      'Something went wrong with XFile uploading..',
    );
  }
}

/// {@template tribly_uploader}
class VoidCatUploader extends Uploader {
  @override
  String get endpoint => 'https://void.cat/upload';

  @override
  Future<String?> upload({
    required XFile file,
  }) async {
    try {
      final uri = Uri.parse('https://void.cat/upload');

      final List<int> fileBytes = await file.readAsBytes();

      final mime = lookupMimeType(file.path);

      final mimeType = mime ?? 'application/octet-stream';
      final sha256Digest = _getSha256Digest(fileBytes);

      final headers = <String, String>{
        'V-Content-Type': mimeType,
        'V-Full-Digest': sha256Digest,
        'V-Filename': basename(file.path),
      };

      // submit it.
      final response = await http.post(
        uri,
        headers: headers,
        body: fileBytes,
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);
        final fileId = decoded['file']['id'];

        return 'https://void.cat/d/$fileId';
      } else {
        return null;
      }
    } catch (e) {
      debugPrint(e.toString());

      return null;
    }
  }

  String _getSha256Digest(List<int> data) {
    const sha256 = crypto.sha256;
    final digest = sha256.convert(data);
    return digest.toString();
  }
}

/// {@template tribly_uploader}
class NostrImgUploader extends Uploader {
  @override
  String get endpoint => 'https://nostrimg.com/api/upload';

  @override
  Future<String?> upload({
    required XFile file,
  }) async {
    try {
      final uri = Uri.parse(endpoint);

      final request = http.MultipartRequest('POST', uri);

      final bytes = await file.readAsBytes();

      request.files.add(
        kIsWeb
            ? http.MultipartFile.fromBytes(
                'image',
                bytes,
                filename: basename(file.path),
                contentType: _mediaType(file.path),
              )
            : await http.MultipartFile.fromPath(
                'image',
                file.path,
                filename: basename(file.path),
                contentType: _mediaType(file.path),
              ),
      );

      final response = await request.send();

      final responseString = await response.stream.bytesToString();
      final decoded = jsonDecode(responseString);
      debugPrint(decoded.toString());
      if (response.statusCode == 200) {
        final link = decoded['data']['link'] as String?;

        if (link == null) return null;

        return link;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint(e.toString());

      return null;
    }
  }

  MediaType? _mediaType(String path) {
    final mimeType = lookupMimeType(path);

    if (mimeType != null) {
      return MediaType.parse(mimeType);
    }

    return MediaType('image', 'png');
  }
}

/// {@template tribly_uploader}
class NostrBuildUploader extends Uploader {
  @override
  String get endpoint => 'https://nostr.build/upload.php';

  @override
  Future<String?> upload({
    required XFile file,
  }) async {
    try {
      final uri = Uri.parse(endpoint);

      final request = http.MultipartRequest('POST', uri);

      request.files.add(
        http.MultipartFile(
          'fileToUpload',
          file.readAsBytes().asStream(),
          await file.length(),
          filename: file.path.split('/').last,
        ),
      );

      /// get the response from the api.
      final response = await request.send();
      final responseData = await response.stream.toBytes();
      final responseString = String.fromCharCodes(responseData);

      final contextFilteredString = responseString
          .replaceAll('\n', '')
          .replaceAll(' ', '')
          .split('"')
          .where((elem) => elem.contains('https://image.nostr.build'))
          .where((elem) => elem.contains(_getFileExtension(file)))
          .toList();

      return _extractLinkFromHttpsToFileExtension(
        contextFilteredString.first,
        _getFileExtension(file),
      );
    } catch (e) {
      debugPrint(e.toString());

      return null;
    }
  }

  String _getFileExtension(XFile file) {
    return file.path.split('.').last;
  }

  String _extractLinkFromHttpsToFileExtension(
    String text,
    String extension,
  ) {
    final indexOfHttps = text.indexOf('https://image.nostr.build');
    final indexOfExtension = text.indexOf(extension, indexOfHttps);

    final substringedLink = text.substring(
      indexOfHttps,
      indexOfExtension + extension.length,
    );

    return substringedLink.trim();
  }
}
