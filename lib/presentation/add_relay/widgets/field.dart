import 'package:flutter/material.dart';

import '../../../constants/strings.dart';
import '../../../services/utils/routing.dart';
import '../../general/text_field.dart';

class RelayUrlField extends StatelessWidget {
  const RelayUrlField({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      hint: AppStrings.relayUrlHint,
      label: AppStrings.addRelayUrlLabel,
      controller: Routing.appCubit.relayUrlController!,
    );
  }
}
