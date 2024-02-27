import 'dart:io';

import 'package:ditto/presentation/general/widget/note_card/wudgets/image_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:image_picker/image_picker.dart';

class ImageFullView extends StatelessWidget {
  const ImageFullView({
    super.key,
    this.link,
    required this.heroTag,
    this.imageFile,
  });

  final String? link;
  final String heroTag;
  final XFile? imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          InteractiveViewer(
            child: Builder(
              builder: (context) {
                if (link != null) {
                  return ImageContent(
                      heroTag: heroTag, link: link!, fit: BoxFit.fitWidth);
                } else if (imageFile != null) {
                  return Image.file(
                    File(imageFile!.path),
                    fit: BoxFit.fitWidth,
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
          AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            iconTheme: const IconThemeData(color: Colors.white),
            leading: IconButton(
              icon: const Icon(FlutterRemix.close_line),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
        ],
      ),
    );
  }
}
