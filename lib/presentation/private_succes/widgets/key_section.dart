import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../buisness_logic/private_key_gen_success_cubit/private_key_gen_success_cubit.dart';
import 'field_suffix.dart';
import 'key_field.dart';

class KeySection extends StatelessWidget {
  const KeySection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PrivateKeyGenSuccessCubit, PrivateKeyGenSuccessState>(
      builder: (context, state) {
        return Stack(
          alignment: Alignment.centerRight,
          children: <Widget>[
            KeyField(
              text: state.privateKey!,
              isPasswordVisible: state.isPasswordVisible,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FieldSuffixIcon(
                  icon: state.isPasswordVisible
                      ? FlutterRemix.eye_close_line
                      : FlutterRemix.eye_line,
                  onPressed: () {
                    context
                        .read<PrivateKeyGenSuccessCubit>()
                        .togglePrivateKeyFieldVisibility();
                  },
                ),
                FieldSuffixIcon(
                  icon: FlutterRemix.file_copy_2_line,
                  onPressed: () {
                    context
                        .read<PrivateKeyGenSuccessCubit>()
                        .copyPrivateKey(context);
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
