import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../general/widget/margined_body.dart';
import '../general/widget/note_card/wudgets/image_content.dart';
import 'widgets/slider.dart';

class ImagesFullView extends StatelessWidget {
  const ImagesFullView({
    super.key,
    required this.imageLinks,
    this.initialIndex = 0,
  });
  final List<String> imageLinks;
  final int initialIndex;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: imageLinks.length,
      initialIndex: initialIndex,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.black,
          iconTheme: const IconThemeData(color: Colors.white),
          toolbarHeight: kToolbarHeight,
          leading: IconButton(
            icon: Icon(FlutterRemix.close_line, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        backgroundColor: Colors.black,
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            TabBarView(
                children: imageLinks.map((imageLink) {
              return InteractiveViewer(
                child: ImageContent(
                  link: imageLink,
                  fit: BoxFit.fitWidth,
                  heroTag: imageLink,
                  shouldOpenFullViewOnTap: false,
                ),
              );
            }).toList()),
            Container(
              margin: EdgeInsets.only(bottom: MarginedBody.defaultMargin.left),
              child: ImagesSlider(imageLinks: imageLinks),
            ),
          ],
        ),
      ),
    );
  }
}
