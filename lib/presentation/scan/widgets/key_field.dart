import 'package:ditto/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../buisness_logic/auth_cubit/auth_cubit.dart';
import '../../../constants/app_strings.dart';

class KeyField extends StatelessWidget {
  const KeyField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Animate(
          effects: [
            FadeEffect(),
            SlideEffect(begin: Offset(-0.25, 0)),
          ],
          delay: const Duration(milliseconds: 400),
          child: Text(
            AppStrings.yourPrivateKey,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w300,
                ),
          ),
        ),
        const SizedBox(height: 5),
        Animate(
          effects: [
            FadeEffect(),
            SlideEffect(begin: Offset(-0.25, 0)),
          ],
          delay: const Duration(milliseconds: 600),
          child: TextField(
            controller: cubit.existentKeyController,
            decoration: InputDecoration(
              hintText: AppStrings.writeYourKey,
              suffixIcon: GestureDetector(
                onTap: () {
                  Clipboard.getData('text/plain').then(
                    (value) {
                      if (value != null && value.text != null) {
                        cubit.existentKeyController!.text = value.text!;
                      }
                    },
                  );
                },
                child: Icon(
                  FlutterRemix.clipboard_line,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
