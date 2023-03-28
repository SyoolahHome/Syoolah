import 'package:ditto/constants/colors.dart';
import 'package:ditto/presentation/home/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    const logoSize = 50.0;

    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      leading: IconButton(
        icon: const Icon(FlutterRemix.arrow_left_line),
        color: AppColors.white,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: const Logo(logoSize: logoSize),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
