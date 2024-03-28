import 'package:ditto/buisness_logic/lnd/lnd_cubit.dart';
import 'package:ditto/presentation/general/widget/button.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:ditto/presentation/lnd_info_from/widgets/app_bar.dart';
import 'package:ditto/services/utils/app_utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/utils/paths.dart';
import 'widgets/lnd_username_field.dart';

class LndInfoFrom extends StatelessWidget {
  LndInfoFrom({super.key});

  LndCubit? cubit;
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    cubit = args["cubit"] as LndCubit?;

    return BlocProvider<LndCubit>.value(
      value: cubit!,
      child: Scaffold(
        appBar: LndInfoFromBar(),
        body: MarginedBody(
          child: Column(
            children: <Widget>[
              SizedBox(height: 40),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Please, choose a username for your LND Adress.".tr(),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              SizedBox(height: 25),
              LNDUsernameField(),
              Spacer(),
              BlocBuilder<LndCubit, LndState>(
                builder: (context, state) {
                  final username = state.username;

                  return Text(
                    username?.isNotEmpty ?? false
                        ? "${username}@roundabout.one".tr()
                        : "",
                    style: Theme.of(context).textTheme.headlineSmall,
                  );
                },
              ),
              Spacer(),
              SizedBox(
                width: double.infinity,
                child: BlocBuilder<LndCubit, LndState>(
                  builder: (context, state) {
                    return RoundaboutButton(
                      onTap: state.username?.isNotEmpty ?? false
                          ? () {
                              Navigator.of(context).pushNamed(
                                Paths.lndCreationSuccess,
                                arguments: {"cubit": cubit},
                              );
                            }
                          : null,
                      text: "submit".tr(),
                      icon: AppUtils.instance
                          .directionality_arrow_right_line(context),
                    );
                  },
                ),
              ),
              SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}
