import 'package:flutter/material.dart';

import '../../presentation/private_succes/private_key_gen_success.dart';

abstract class BottomSheets {
  static Future<dynamic> showPrivateKeyGenSuccess(BuildContext context) {
    return showModalBottomSheet(
      isScrollControlled: false,
      clipBehavior: Clip.hardEdge,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      
      context: context,
      builder: (context) {
        return const PrivateKeyGenSuccess();
      },
    );
  }
}
