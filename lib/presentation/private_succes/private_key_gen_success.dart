import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:ditto/services/database/local/local.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../buisness_logic/private_key_gen_success_cubit/private_key_gen_success_cubit.dart';
import '../../constants/colors.dart';
import '../../constants/strings.dart';
import '../../services/utils/paths.dart';

class PrivateKeyGenSuccess extends StatelessWidget {
  const PrivateKeyGenSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    const heightSeparator = 10.0;

    return BlocProvider<PrivateKeyGenSuccessCubit>(
      create: (context) => PrivateKeyGenSuccessCubit(),
      child: Scaffold(
        body: MarginedBody(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              const Spacer(),
              Icon(
                FlutterRemix.checkbox_circle_line,
                color: AppColors.teal,
                size: 75,
              ),
              const SizedBox(height: heightSeparator),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  AppStrings.keyGeneratedSuccessfullyText,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.normal,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              const Spacer(),
              BlocBuilder<PrivateKeyGenSuccessCubit, PrivateKeyGenSuccessState>(
                  builder: (context, state) {
                return Stack(
                  alignment: Alignment.centerRight,
                  children: <Widget>[
                    TextField(
                      obscureText: state.isPasswordVisible,
                      controller: TextEditingController(text: state.privateKey),
                      style: Theme.of(context).textTheme.labelSmall,
                      enabled: false,
                      decoration: InputDecoration(
                        fillColor: AppColors.lighGrey,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          color: AppColors.lighGrey,
                          child: IconButton(
                            icon: Icon(
                              state.isPasswordVisible
                                  ? FlutterRemix.eye_close_line
                                  : FlutterRemix.eye_line,
                              color: AppColors.teal,
                            ),
                            onPressed: () {
                              context
                                  .read<PrivateKeyGenSuccessCubit>()
                                  .togglePrivateKeyFieldVisibility();
                            },
                          ),
                        ),
                        Container(
                          color: AppColors.lighGrey,
                          child: IconButton(
                            icon: Icon(
                              FlutterRemix.file_copy_2_line,
                              color: AppColors.teal,
                            ),
                            onPressed: () {
                              context
                                  .read<PrivateKeyGenSuccessCubit>()
                                  .copyPrivateKey(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }),
              const Spacer(),
              SizedBox(
                height: 45,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Future.delayed(kThemeAnimationDuration, () {
                      Navigator.pushReplacementNamed(context, Paths.bottomBar);
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.teal.withOpacity(0.95),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    AppStrings.start,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
              ),
              const SizedBox(height: heightSeparator),
            ],
          ),
        ),
      ),
    );
  }
}
