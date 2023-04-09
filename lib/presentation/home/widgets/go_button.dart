import 'package:ditto/constants/colors.dart';
import 'package:ditto/constants/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../buisness_logic/auth_cubit/auth_cubit.dart';
import '../../../services/utils/bottom_sheet.dart';
import '../../../services/utils/paths.dart';
import '../../../services/utils/snackbars.dart';
import '../../bottom_bar_screen/bottom_bar_screen.dart';
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
          BottomSheets.showPrivateKeyGenSuccess(context).then((_) {
            // if (context.read<AuthCubit>().nameFocusNode!.hasFocus) {
            context.read<AuthCubit>().nameFocusNode!.unfocus();
            // }
          });
        } else if (state.isSignedOut) {
          Navigator.of(context).pushNamed(Paths.main);
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
                onPressed: () {
                  context.read<AuthCubit>().authenticate();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.white.withOpacity(0.95),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  AppStrings.continueText,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: scaffoldColor,
                        fontWeight: FontWeight.w500,
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
