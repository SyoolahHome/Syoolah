import 'package:ditto/buisness_logic/auth_cubit/auth_cubit.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/colors.dart';
import '../../../constants/strings.dart';
import '../../../services/utils/paths.dart';
import '../../../services/utils/snackbars.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldColor =
        context.findAncestorWidgetOfExactType<Scaffold>()!.backgroundColor;
    final cubit = context.read<AuthCubit>();

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state.authenticated) {
          Navigator.of(context).pushNamed(Paths.bottomBar);
        } else if (state.isSignedOut) {
          Navigator.of(context).pushNamed(Paths.keyAuth);
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
                  cubit.handleExistentKey();
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
            if (state.isSavingExistentKey)
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
          ],
        );
      },
    );
  }
}
