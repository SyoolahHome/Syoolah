import 'dart:io';

import 'package:http/http.dart' as http;

class FileUpload {
  Future<String> call(File file) async {
    try {
      /// upload file to api.
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('https://nostr.build/upload.php'),
      );
      request.files.add(
        http.MultipartFile(
          'file',
          file.readAsBytes().asStream(),
          file.lengthSync(),
          filename: file.path.split('/').last,
        ),
      );

      /// get the response from the api.
      final response = await request.send();
      final responseData = await response.stream.toBytes();
      final responseString = String.fromCharCodes(responseData);

      // extract the url of the file from the response with a regex: "/https:\/\/nostr\.build\/(?:i|av)\/nostr\.build_[a-z0-9]{64}\.[a-z0-9]+/i".
      final url = RegExp(
        r'/https:\/\/nostr\.build\/(?:i|av)\/nostr\.build_[a-z0-9]{64}\.[a-z0-9]+/i',
      ).firstMatch(responseString)!.group(0)!;

      return url;
    } catch (e) {
      rethrow;
    }
  }
}
