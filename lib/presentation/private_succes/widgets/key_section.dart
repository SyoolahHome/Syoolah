import 'package:ditto/buisness_logic/private_key_gen_success_cubit/private_key_gen_success_cubit.dart';
import 'package:ditto/presentation/private_succes/widgets/field_suffix.dart';
import 'package:ditto/presentation/private_succes/widgets/key_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../constants/app_enums.dart';

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
    Widget widget({
      required String value,
      required bool isVisible,
      required VoidCallback onPressed,
    }) {
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
              text: value,
              isVisible: isVisible,
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
                    icon: isVisible
                        ? FlutterRemix.eye_close_line
                        : FlutterRemix.eye_line,
                    onPressed: onPressed,
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
                    } else if (type == KeySectionType.publicKey) {
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
    }

    final resultWidget =
        BlocBuilder<PrivateKeyGenSuccessCubit, PrivateKeyGenSuccessState>(
      builder: (context, state) {
        final cubit = context.read<PrivateKeyGenSuccessCubit>();
        final privateKey = cubit.decideWhichKeyToShow(type);

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (state.mnemonic != null && state.mnemonic!.isNotEmpty) ...[
              widget(
                value: state.mnemonic!,
                isVisible: state.isMnemonicVisible,
                onPressed: () {
                  cubit.toggleMnemonicFieldVisibility();
                },
              ),
              const SizedBox(height: 7.5),
            ],
            widget(
              value: privateKey,
              isVisible: state.isPrivateKeyVisible,
              onPressed: () {
                cubit.togglePrivateKeyFieldVisibility();
              },
            ),
          ],
        );
      },
    );

    if (type == KeySectionType.privateKey) {
      return resultWidget;
    } else {
      return BlocProvider<PrivateKeyGenSuccessCubit>(
        create: (context) => PrivateKeyGenSuccessCubit(),
        child: Builder(
          builder: (context) {
            return resultWidget;
          },
        ),
      );
    }
  }
}
