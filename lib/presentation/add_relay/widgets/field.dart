import 'package:ditto/presentation/general/text_field.dart';
import 'package:ditto/services/utils/routing.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class RelayUrlField extends StatelessWidget {
  const RelayUrlField({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      hint: "relayUrlHint".tr(),
      label: "addRelayUrlLabel".tr(),
      controller: Routing.appCubit.relayUrlController!,
    );
  }
}
