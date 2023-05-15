import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../buisness_logic/private_key_gen_success_cubit/private_key_gen_success_cubit.dart';
import 'widgets/button.dart';
import 'widgets/key_section.dart';
import 'widgets/success_icon.dart';
import 'widgets/success_text.dart';

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
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Spacer(),
              SuccessIcon(),
              SizedBox(height: heightSeparator),
              SuccessText(customText: customText),
              Spacer(),
              KeySection(onCopy: onCopy),
              Spacer(),
              StartButton(),
              SizedBox(height: heightSeparator),
            ],
          ),
        ),
      ),
    );
  }
}
