import 'package:ditto/buisness_logic/private_key_gen_success_cubit/private_key_gen_success_cubit.dart';
import 'package:ditto/presentation/current_user_keys/widgets/danger_box.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:ditto/presentation/private_succes/widgets/button.dart';
import 'package:ditto/presentation/private_succes/widgets/key_section.dart';
import 'package:ditto/presentation/private_succes/widgets/success_icon.dart';
import 'package:ditto/presentation/private_succes/widgets/success_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PrivateKeyGenSuccess extends StatelessWidget {
  const PrivateKeyGenSuccess({super.key, this.onCopy, this.customText});

  final VoidCallback? onCopy;
  final String? customText;
  @override
  Widget build(BuildContext context) {
    const heightSeparator = 10.0;

    return BlocProvider<PrivateKeyGenSuccessCubit>(
      create: (context) => PrivateKeyGenSuccessCubit(),
      child: Scaffold(
        body: MarginedBody(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              const Spacer(),
              const SuccessIcon(),
              const SizedBox(height: heightSeparator),
              SuccessText(customText: customText),
              const Spacer(),
              DangerBox(
                customText: "copyItNowDanger".tr(),
              ),
              const Spacer(),
              KeySection(onCopy: onCopy),
              const Spacer(),
              const StartButton(),
              const SizedBox(height: heightSeparator),
            ],
          ),
        ),
      ),
    );
  }
}
