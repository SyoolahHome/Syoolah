import 'package:ditto/model/translation_lang.dart';
import 'package:ditto/presentation/general/widget/button.dart';
import 'package:ditto/services/utils/snackbars.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../buisness_logic/translation/translation_cubit.dart';
import '../../../services/utils/app_utils.dart';

class TranslationOptions extends StatelessWidget {
  const TranslationOptions({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TranslationCubit>();

    return Row(
      children: <Widget>[
        UmrahtyButton(
          padding: EdgeInsets.symmetric(horizontal: 0),
          onTap: () {},
          iconSize: 22,
          text: "auto_detect".tr(),
          isOnlyBorder: true,
        ),
        SizedBox(width: 5),
        Icon(AppUtils.instance.isArabic(context)
            ? FlutterRemix.arrow_left_s_fill
            : FlutterRemix.arrow_right_s_fill),
        SizedBox(width: 5),
        BlocSelector<TranslationCubit, TranslationState, TranslationLang>(
          selector: (state) => state.selectedTargetLang,
          builder: (context, selectedTargetLang) {
            return Expanded(
              child: SizedBox(
                child: UmrahtyButton(
                  onTap: () {
                    cubit.openLangSelection(context, onLangSelected: (lang) {
                      FocusScopeNode currentFocus = FocusScope.of(context);

                      if (!currentFocus.hasPrimaryFocus) {
                        currentFocus.unfocus();
                      }
                      // SnackBars.text(
                      //   context,
                      //   "lang_selected".tr(args: [
                      //     lang.name,
                      //   ]),
                      // );
                    });
                  },
                  icon: Icons.arrow_drop_down,
                  iconSize: 22,
                  text: selectedTargetLang.name,
                  // isOnlyBorder: true,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
