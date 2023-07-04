import 'package:ditto/buisness_logic/private_key_gen_success_cubit/private_key_gen_success_cubit.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:ditto/presentation/general/widget/title.dart';
import 'package:ditto/presentation/private_succes/widgets/button.dart';
import 'package:ditto/presentation/private_succes/widgets/key_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/app_enums.dart';
import '../general/pattern_widget.dart';

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

    return PatternScaffold(
      body: BlocProvider<PrivateKeyGenSuccessCubit>(
        create: (context) => PrivateKeyGenSuccessCubit(),
        child: Center(
          child: MarginedBody(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const SizedBox(height: heightSeparator * 2),
                HeadTitle(title: title),
                const SizedBox(height: heightSeparator * 2),
                KeySection(
                  type: type == HiddenPrivateKeySectionType.privateKey
                      ? KeySectionType.privateKey
                      : KeySectionType.nsecKey,
                ),
                const SizedBox(height: heightSeparator * 2),
                const StartButton(),
                const SizedBox(height: heightSeparator * 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
