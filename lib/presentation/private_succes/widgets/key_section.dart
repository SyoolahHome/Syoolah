import 'package:ditto/buisness_logic/private_key_gen_success_cubit/private_key_gen_success_cubit.dart';
import 'package:ditto/presentation/private_succes/widgets/field_suffix.dart';
import 'package:ditto/presentation/private_succes/widgets/key_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

enum KeySectionType {
  privateKey,
  publicKey,
  nPubKey,
  nsecKey,
}

class KeySection extends StatelessWidget {
  const KeySection({
    super.key,
    this.type = KeySectionType.privateKey,
    this.showEyeIconButton = true,
    this.onCopy,
  });

  final KeySectionType type;
  final VoidCallback? onCopy;
  final bool showEyeIconButton;
  @override
  Widget build(BuildContext context) {
    final widget =
        BlocBuilder<PrivateKeyGenSuccessCubit, PrivateKeyGenSuccessState>(
      builder: (context, state) {
        final cubit = context.read<PrivateKeyGenSuccessCubit>();
        final keyToShow = cubit.decideWhichKeyToShow(type);

        return Stack(
          alignment: Alignment.centerRight,
          children: <Widget>[
            Animate(
              delay: 400.ms,
              effects: const <Effect>[
                FadeEffect(),
                SlideEffect(begin: Offset(0, 0.5)),
              ],
              child: KeyField(
                text: keyToShow,
                isPasswordVisible: state.isPasswordVisible,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                if (showEyeIconButton)
                  Animate(
                    delay: 800.ms,
                    effects: const <Effect>[
                      FadeEffect(),
                    ],
                    child: FieldSuffixIcon(
                      icon: state.isPasswordVisible
                          ? FlutterRemix.eye_close_line
                          : FlutterRemix.eye_line,
                      onPressed: () {
                        context
                            .read<PrivateKeyGenSuccessCubit>()
                            .togglePrivateKeyFieldVisibility();
                      },
                    ),
                  ),
                Animate(
                  delay: 1000.ms,
                  effects: const <Effect>[
                    FadeEffect(),
                  ],
                  child: FieldSuffixIcon(
                    icon: FlutterRemix.file_copy_2_line,
                    onPressed: () {
                      if (type == KeySectionType.privateKey) {
                        context
                            .read<PrivateKeyGenSuccessCubit>()
                            .copyPrivateKey(context);
                      } else {
                        context
                            .read<PrivateKeyGenSuccessCubit>()
                            .copyPublicKey(context);
                      }

                      onCopy?.call();
                    },
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );

    if (type == KeySectionType.privateKey) {
      return widget;
    } else {
      return BlocProvider<PrivateKeyGenSuccessCubit>(
        create: (context) => PrivateKeyGenSuccessCubit(),
        child: Builder(
          builder: (context) {
            return widget;
          },
        ),
      );
    }
  }
}
