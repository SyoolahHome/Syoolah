import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

import 'image_content.dart';

class ImageFullView extends StatelessWidget {
  const ImageFullView({
    super.key,
    this.link,
    required this.heroTag,
    this.imageFile,
  });

  final String? link;
  final String heroTag;
  final File? imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          if (link != null) ...[
            ImageContent(
              heroTag: heroTag,
              link: link!,
              fit: BoxFit.fitWidth,
            ),
          ] else if (imageFile != null) ...[
            Image.file(
              imageFile!,
              fit: BoxFit.fitWidth,
            ),
          ],
          AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              iconTheme: const IconThemeData(color: Colors.white),
              leading: IconButton(
                icon: const Icon(FlutterRemix.close_line),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )),
        ],
      ),
    );
  }
}
