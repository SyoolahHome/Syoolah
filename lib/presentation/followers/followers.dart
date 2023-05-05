import 'package:ditto/buisness_logic/profile/profile_cubit.dart';
import 'package:ditto/presentation/followings/widgets/empty_list.dart';
import 'package:ditto/presentation/sign_up/widgets/users_list_to_follow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/app_bar.dart';

class Followers extends StatelessWidget {
  Followers({super.key});

  List<List<String>>? tags;
  ProfileCubit? profileCubit;
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    tags =
        (args["tags"] as List).map((e) => (e as List).cast<String>()).toList();
    profileCubit = args["profileCubit"] as ProfileCubit;

    return BlocProvider<ProfileCubit>.value(
      value: profileCubit!,
      child: Scaffold(
        appBar: CustomAppBar(followingsList: tags!.map((e) => e.last).toList()),
        body: Builder(
          builder: (context) {
            if ((tags ?? []).isEmpty) {
              return EmptyList();
            } else {
              return UsersListToFollow(
                  pubKeys: tags!.map((e) => e.last).toList());
            }
          },
        ),
      ),
    );
  }
}
