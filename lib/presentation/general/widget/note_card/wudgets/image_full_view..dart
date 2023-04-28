import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

import 'image_content.dart';

class ImageFullView extends StatelessWidget {
  const ImageFullView({
    super.key,
    required this.link,
    required this.heroTag,
  });

  final String link;
  final String heroTag;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          ImageContent(
            heroTag: heroTag,
            link: link,
            fit: BoxFit.fitWidth,
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
              )),
        ],
      ),
    );
  }
}
