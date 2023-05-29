import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../general/widget/margined_body.dart';
import '../general/widget/note_card/wudgets/image_content.dart';

class ImagesFullView extends StatefulWidget {
  const ImagesFullView({
    super.key,
    required this.imageLinks,
    this.initialIndex = 0,
  });
  final List<String> imageLinks;
  final int initialIndex;

  @override
  State<ImagesFullView> createState() => _ImagesFullViewState();
}

class _ImagesFullViewState extends State<ImagesFullView> {
  PageController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: PageView.builder(
        itemCount: widget.imageLinks.length,
        controller: _controller,
        itemBuilder: (context, index) {
          final currentImageLink = widget.imageLinks[index];

          return InteractiveViewer(
            child: ImageContent(
              link: currentImageLink,
              fit: BoxFit.fitWidth,
              heroTag: currentImageLink,
            ),
          );
        },
      ),
    );
  }
}
