import 'package:ditto/buisness_logic/lnd/lnd_cubit.dart';
import 'package:ditto/presentation/general/widget/button.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:ditto/presentation/private_succes/widgets/key_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../services/utils/paths.dart';
import '../sign_up/widgets/or_divider.dart';
import 'widgets/lnurl_field.dart';

class LndCreationSuccess extends StatelessWidget {
  LndCreationSuccess({super.key});

  LndCubit? cubit;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    cubit = args["cubit"] as LndCubit;

    return BlocProvider<LndCubit>.value(
      value: cubit!,
      child: Builder(builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: Text("f1_zaplocker".tr()),
            actions: [
              KeshiButton(
                onTap: () {
                  Navigator.of(context).pushNamed(Paths.relaysConfig);
                },
                text: "relays".tr(),
                isSmall: true,
              ),
              SizedBox(width: 15),
            ],
          ),
          body: MarginedBody(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 40),
                  Row(
                    children: <Widget>[
                      Text(
                        "your_info".tr(),
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Spacer(),
                      Icon(
                        FlutterRemix.flashlight_line,
                        color: Colors.yellow,
                      )
                    ],
                  ),
                  SizedBox(height: 40),
                  Text("username".tr()),
                  SizedBox(height: 5),
                  KeyField(
                    text: cubit!.state.username ?? "",
                    isPasswordVisible: false,
                  ),
                  SizedBox(height: 20),
                  Text("lnd_adress".tr()),
                  SizedBox(height: 5),
                  KeyField(
                    text: cubit!.state.lndAddress ?? "",
                    isPasswordVisible: false,
                  ),
                  SizedBox(height: 20),
                  Text("lnurl".tr()),
                  SizedBox(height: 5),
                  LNURLKeyField(
                    lnurl: cubit!.state.lnurl ?? "",
                  ),
                  SizedBox(height: 30),
                  Center(child: OrDivider()),
                  SizedBox(height: 30),
                  Row(
                    children: <Widget>[
                      Text(
                        "payments",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Spacer(),
                      Icon(
                        FlutterRemix.flashlight_line,
                        color: Colors.yellow,
                      ),
                    ],
                  ),
                  SizedBox(height: 25),
                  Center(
                    child: Text("No Pending Payments Yet!"),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
