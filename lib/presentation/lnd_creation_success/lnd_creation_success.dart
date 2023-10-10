import 'package:ditto/buisness_logic/lnd/lnd_cubit.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:ditto/presentation/private_succes/widgets/key_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

import 'widgets/lnurl_field.dart';

class LndCreationSuccess extends StatelessWidget {
  const LndCreationSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: MarginedBody(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 40),
              Row(
                children: <Widget>[
                  Text(
                    "your_info",
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
                text: "Anas",
                isPasswordVisible: false,
              ),
              SizedBox(height: 20),
              Text("lnd_adress".tr()),
              SizedBox(height: 5),
              KeyField(
                text: "Anas@sakhir.me",
                isPasswordVisible: false,
              ),
              SizedBox(height: 20),
              Text("lnurl".tr()),
              SizedBox(height: 5),
              LNURLKeyField(
                lnurl: "LNURLqfkjeqivfveufoefmlebfml",
              ),
              //   SizedBox(height: 40),
              //   Row(
              //     children: <Widget>[
              //       Text(
              //         "payments",
              //         style: Theme.of(context).textTheme.headlineMedium,
              //       ),
              //       Spacer(),
              //       Icon(
              //         FlutterRemix.flashlight_line,
              //         color: Colors.yellow,
              //       )
              //     ],
              //   ),
            ],
          ),
        ),
      ),
    );
  }
}
