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
      assert(contextFilteredString.length == 1);

      return extractLinkFromHttpsToFileExtension(
        contextFilteredString.first,
        getFileExtension(file),
      );
    } catch (e) {
      rethrow;
    }
  }

  String getFileExtension(File file) {
    return file.path.split('.').last;
  }
}

String extractLinkFromHttpsToFileExtension(String text, String extension) {
  // cut only link from text that starts by http and ends with the .png or .jpg extension.
  final indexOfHttps = text.indexOf('https');
  final indexOfExtension = text.indexOf(extension);

  final substringedLink = text.substring(
    indexOfHttps,
    indexOfExtension + extension.length,
  );

  return substringedLink.trim();
}
