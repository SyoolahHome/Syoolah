import 'package:ditto/buisness_logic/lnd/lnd_cubit.dart';
import 'package:ditto/constants/app_enums.dart';
import 'package:ditto/presentation/general/widget/bottom_sheet_title_with_button.dart';
import 'package:ditto/presentation/general/widget/button.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../../services/utils/paths.dart';
import '../../general/pattern_widget.dart';
import '../../private_succes/widgets/key_section.dart';

class LndAdressCreationWidget extends StatelessWidget {
  const LndAdressCreationWidget({
    super.key,
    required this.lndCubit,
  });

  final LndCubit lndCubit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LndCubit>.value(
      value: lndCubit,
      child: PatternScaffold(
        body: MarginedBody(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 20),
              BottomSheetTitleWithIconButton(
                title: "create_address_lnd".tr(),
              ),
              SizedBox(height: 20),
              Text("myPublicKey".tr()),
              SizedBox(height: 7.5),
              KeySection(
                type: KeySectionType.nPubKey,
              ),
              SizedBox(height: 30),
              Align(
                alignment: Alignment.centerRight,
                child: UmrahtyButton(
                  onTap: () {
                    Navigator.pop(context);

                    Navigator.of(context).pushNamed(
                      Paths.lndInfoFrom,
                      arguments: {
                        'cubit': lndCubit,
                      },
                    );
                    // lndCubit.createAddress(
                    //   onSuccess: () {
                    //     Navigator.of(context).pushNamed(
                    //       Paths.lndInfoFrom,
                    //       arguments: {
                    //         'cubit': lndCubit,
                    //       },
                    //     );
                    //   },
                    // );
                  },
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  isRounded: true,
                  text: "create".tr(),
                  isSmall: true,
                  icon: FlutterRemix.flashlight_line,
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
