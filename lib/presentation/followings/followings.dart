import 'package:ditto/presentation/sign_up/widgets/users_list_to_follow.dart';
import 'package:flutter/material.dart';

import 'widgets/app_bar.dart';

class Followings extends StatelessWidget {
  Followings({super.key});

  List<List<String>>? tags;
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    tags = (args as List).map((e) => (e as List).cast<String>()).toList();

    return Scaffold(
      appBar: CustomAppBar(),
      body:
          // Column(
          //   children: List.generate(
          //     tags!.length,
          //     (index) => Text(
          //       tags![index].toString(),
          //     ),
          //   ),
          // )
          UsersListToFollow(pubKeys: tags!.map((e) => e.last).toList()),
    );
  }
}
