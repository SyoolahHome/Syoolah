import 'package:ditto/buisness_logic/lnd/lnd_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../general/text_field.dart';

class LNDUsernameField extends StatelessWidget {
  const LNDUsernameField({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LndCubit>();

    return CustomTextField(
      showClearButton: true,
      controller: cubit.usernameController,
      label: "adress_username".tr(),
      hint: "username".tr(),
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    );
  }
}
