import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../buisness_logic/private_key_gen_success_cubit/private_key_gen_success_cubit.dart';
import '../current_user_keys/widgets/private_key_section.dart';
import '../general/widget/title.dart';
import 'widgets/button.dart';
import 'widgets/key_section.dart';
import 'widgets/success_icon.dart';
import 'widgets/success_text.dart';

class PrivateKey extends StatelessWidget {
  const PrivateKey({
    super.key,
    required this.type,
    required this.title,
  });

  final HiddenPrivateKeySectionType type;
  final String title;
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
              SizedBox(height: heightSeparator * 2),
              HeadTitle(title: title),
              SizedBox(height: heightSeparator * 2),
              KeySection(
                type: type == HiddenPrivateKeySectionType.privateKey
                    ? KeySectionType.privateKey
                    : KeySectionType.nsecKey,
              ),
              SizedBox(height: heightSeparator * 2),
              StartButton(),
              SizedBox(height: heightSeparator * 2),
            ],
          ),
        ),
      ),
    );
  }
}
