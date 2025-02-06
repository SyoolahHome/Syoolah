import 'package:ditto/constants/abstractions/abstractions.dart';
import 'package:ditto/presentation/lnd/widgets/lnd_view.dart';
import 'package:ditto/presentation/lnd/widgets/no_lnd_support.dart';

import 'widgets/lnd_bar.dart';

import 'package:flutter/material.dart';

class LND extends BottomBarScreen {
  const LND({
    super.key,
    this.showNoSupport = true,
  });

  final bool showNoSupport;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: LNDAppBar(),
      body: showNoSupport ? NoLndSupport() : LndView(),
    );

    // return BlocProvider<LndCubit>(
    //   create: (context) => LndCubit(),
    //   child: Builder(
    //     builder: (context) {
    //       final cubit = context.read<LndCubit>();

    //       return Scaffold(
    //         appBar: LNDAppBar(),
    //         body: SizedBox(
    //           width: double.infinity,
    //           child: MarginedBody(
    //             child: Column(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               crossAxisAlignment: CrossAxisAlignment.center,
    //               children: <Widget>[
    //                 SizedBox(height: 40),
    //                 Align(
    //                   alignment: Alignment.centerLeft,
    //                   child: Text(
    //                     "Support for Zaplocker coming Comex Bahrain 2023.",
    //                     style: Theme.of(context).textTheme.headlineSmall,
    //                   ),
    //                 ),
    //                 Spacer(),
    //                 Animate(
    //                   effects: <Effect>[
    //                     SlideEffect(
    //                       begin: Offset(0, -0.075),
    //                       end: Offset(0, 0.075),
    //                       duration: 3000.ms,
    //                     ),
    //                   ],
    //                   onComplete: (controller) =>
    //                       controller.repeat(reverse: true),
    //                   child: Container(
    //                     padding: EdgeInsets.all(40),
    //                     decoration: BoxDecoration(
    //                       color: Theme.of(context)
    //                           .colorScheme
    //                           .background
    //                           .withOpacity(.15),
    //                       shape: BoxShape.circle,
    //                     ),
    //                     child: Icon(
    //                       FlutterRemix.flashlight_line,
    //                       color: Colors.yellow,
    //                       size: 40,
    //                     ),
    //                   ),
    //                 ),
    //                 const SizedBox(height: 30),
    //                 Text(
    //                   "lnd_description".tr(),
    //                   textAlign: TextAlign.center,
    //                   style: Theme.of(context).textTheme.bodyLarge,
    //                 ),
    //                 const SizedBox(height: 32.5),
    //                 OrDivider(
    //                   color: Theme.of(context)
    //                       .colorScheme
    //                       .background
    //                       .withOpacity(.5),
    //                 ),
    //                 const SizedBox(height: 32.5),
    //                 RoundaboutButton(
    //                   padding: const EdgeInsets.symmetric(
    //                     horizontal: 20,
    //                     vertical: 10,
    //                   ),
    //                   onTap: () async {
    //                     final username = await BottomSheetService
    //                         .promptUserForNewLndUsername(
    //                       context: context,
    //                     );

    //                     Navigator.of(context).pushNamed(
    //                       Paths.lndLoading,
    //                       arguments: {
    //                         'cubit': cubit,
    //                         'username': username,
    //                       },
    //                     );
    //                   },
    //                   text: "start".tr(),
    //                   additonalFontSize: 0,
    //                   isRounded: true,
    //                 ),
    //                 Spacer(),
    //               ],
    //             ),
    //           ),
    //         ),
    //       );
    //     },
    //   ),
    // );
  }
}
