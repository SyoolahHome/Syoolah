import 'package:ditto/services/utils/extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

import '../../buisness_logic/cubit/privacy_policy_cubit.dart';
import '../../constants/app_colors.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({
    super.key,
    required this.shouldShowAcceptSwitchTile,
    required this.onAccept,
  });

  final bool shouldShowAcceptSwitchTile;
  final void Function(bool?) onAccept;

  @override
  Widget build(BuildContext context) {
    final height = 10.0;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      child: BlocProvider<PrivacyPolicyCubit>(
        create: (context) => PrivacyPolicyCubit(),
        child: Builder(
          builder: (context) {
            return Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: <Widget>[
                Scrollbar(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.all(15),
                      margin: EdgeInsets.symmetric(vertical: 0),
                      decoration: BoxDecoration(
                        // color: AppColors.lighGrey.withOpacity(.3),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          HtmlWidget(
                            "privacyPolicyContent".tr(),
                            customStylesBuilder: (element) {
                              if (element.classes.contains("anchorLink")) {
                                return {
                                  'color': Colors.blue.shade700.toHex(),
                                };
                              }

                              return null;
                            },
                          ),
                          SizedBox(height: height * 10),
                        ],
                      ),
                    ),
                  ),
                ),
                if (shouldShowAcceptSwitchTile) ...<Widget>[
                  BlocBuilder<PrivacyPolicyCubit, bool>(
                    builder: (context, isAccpeted) {
                      return Container(
                        margin: EdgeInsets.only(bottom: 0),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: CheckboxListTile(
                          title: Text(
                            "acceptPrivacyPolicy".tr(),
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge
                                ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .background
                                      .withOpacity(.7),
                                  fontWeight: FontWeight.normal,
                                ),
                          ),
                          value: isAccpeted,
                          onChanged: (val) {
                            return onAccept(
                              context.read<PrivacyPolicyCubit>().toggle(),
                            );
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                          visualDensity: VisualDensity.standard,
                          contentPadding: EdgeInsets.zero,
                          dense: false,
                        ),
                      );
                    },
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}
