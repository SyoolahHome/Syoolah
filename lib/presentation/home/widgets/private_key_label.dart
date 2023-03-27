import 'package:flutter/material.dart';

import '../../../constants/strings.dart';
import '../../../scan.dart';

class PrivateKeyLabel extends StatelessWidget {
  const PrivateKeyLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: const Text(AppStrings.privateKeyAccess),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ScanKey()),
        );
      },
    );
  }
}
