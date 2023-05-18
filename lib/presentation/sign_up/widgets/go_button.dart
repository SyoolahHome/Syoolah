import 'package:ditto/constants/app_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../buisness_logic/auth_cubit/auth_cubit.dart';
import '../../../services/utils/paths.dart';
import '../../../services/utils/snackbars.dart';
import '../../general/widget/margined_body.dart';

class GoButton extends StatelessWidget {
  const GoButton({
    super.key,
    this.padding = const EdgeInsets.all(10),
  });

  final EdgeInsets padding;
  @override
  Widget build(BuildContext context) {
    final scaffoldColor =
        context.findAncestorWidgetOfExactType<Scaffold>()!.backgroundColor;

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.authenticated) {
        } else if (state.isSignedOut) {
          Navigator.of(context).pushNamed(Paths.SignUp);
        } else if (state.error != null) {
          SnackBars.text(context, state.error!);
        }
      },
      builder: (context, state) {
        return Stack(
          alignment: Alignment.centerRight,
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.white.withOpacity(0.95),
                  foregroundColor: Theme.of(context).primaryColorLight,
                ),
                child: Text(
                  "continueText".tr(),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).primaryColor,
                      ),
                ),
              ),
            ),
            if (!state.isGeneratingNewPrivateKey) ...[
              Container(
                margin: const EdgeInsets.only(right: 10),
                child: Icon(
                  FlutterRemix.arrow_right_fill,
                  color: scaffoldColor,
                ),
              )
            ] else ...[
              Container(
                width: 20,
                height: 20,
                margin: context
                    .findAncestorWidgetOfExactType<MarginedBody>()!
                    .margin,
                child: CircularProgressIndicator(
                  color: context
                      .findAncestorWidgetOfExactType<Scaffold>()!
                      .backgroundColor,
                  strokeWidth: 1.75,
                ),
              ),
            ]
          ],
        );
      },
    );
  }
}
