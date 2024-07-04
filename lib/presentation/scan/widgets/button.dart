import 'dart:ui';

import 'package:ditto/buisness_logic/auth_cubit/auth_cubit.dart';
import 'package:ditto/presentation/general/widget/button.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:ditto/services/bottom_sheet/bottom_sheet_service.dart';
import 'package:ditto/services/utils/paths.dart';
import 'package:ditto/services/utils/snackbars.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomButtons extends StatelessWidget {
  const CustomButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldColor =
        context.findAncestorWidgetOfExactType<Scaffold>()!.backgroundColor;
    final cubit = context.read<AuthCubit>();

    return Animate(
      effects: const [
        FadeEffect(),
        SlideEffect(begin: Offset(0, 0.5)),
      ],
      delay: const Duration(milliseconds: 1000),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state.authenticated) {
            Navigator.of(context).pushReplacementNamed(Paths.bottomBar);
          } else if (state.isSignedOut) {
            Navigator.of(context).pushReplacementNamed(Paths.SignUp);
          } else if (state.error != null) {
            SnackBars.text(context, state.error!);
          }
        },
        builder: (context, state) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Stack(
                alignment: Alignment.centerRight,
                children: <Widget>[
                  SizedBox(
                    width: double.infinity,
                    child: RoundaboutButton(
                      onTap: () {
                        cubit.authenticateWithExistentKey();
                      },
                      text: "login".tr(),
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
              ),
              SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: RoundaboutButton(
                  isOnlyBorder: true,
                  text: "I have my seed phrase".tr(),
                  onTap: () async {
                    final privateKey =
                        await BottomSheetService.privateKeyFromSeedPhrase(
                            context);

                    if (privateKey is String && privateKey.isNotEmpty) {
                      cubit.existentKeyController!.text = privateKey;

                      cubit.authenticateWithExistentKey();
                    }
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
