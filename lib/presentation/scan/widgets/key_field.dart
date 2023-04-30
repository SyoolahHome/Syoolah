import 'package:ditto/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        Text(
          AppStrings.yourPrivateKey,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w300,
              ),
        ),
        const SizedBox(height: 5),
        TextField(
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
                color: AppColors.white.withOpacity(0.8),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
