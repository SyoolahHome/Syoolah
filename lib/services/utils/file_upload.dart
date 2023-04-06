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
          'fileToUpload',
          file.readAsBytes().asStream(),
          file.lengthSync(),
          filename: file.path.split('/').last,
        ),
      );

      /// get the response from the api.
      final response = await request.send();
      final responseData = await response.stream.toBytes();
      final responseString = String.fromCharCodes(responseData);

      final contextFilteredString = responseString
          .replaceAll("\n", "")
          .replaceAll(" ", "")
          .split('"')
          .where((elem) => elem.contains("https://nostr.build"))
          .where((elem) => elem.contains(getFileExtension(file)))
          .toList();

      RegExp exp = RegExp(r'>(.+?)</b></span>');
      Match match = exp.firstMatch(contextFilteredString.toString())!;
      String link = match.group(1)!;

      return link.trim();
    } catch (e) {
      rethrow;
    }
  }

  String getFileExtension(File file) {
    return file.path.split('.').last;
  }
}
