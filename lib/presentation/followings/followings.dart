import 'package:ditto/buisness_logic/global/global_cubit.dart';
import 'package:ditto/buisness_logic/profile/profile_cubit.dart';
import 'package:ditto/presentation/followings/widgets/app_bar.dart';
import 'package:ditto/presentation/followings/widgets/empty_list.dart';
import 'package:ditto/presentation/sign_up/widgets/users_list_to_follow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Followings extends StatelessWidget {
  Followings({super.key});

  List<List<String>>? tags;
  ProfileCubit? profileCubit;
  GlobalCubit? globalCubit;

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    tags =
        (args["tags"] as List).map((e) => (e as List).cast<String>()).toList();
    profileCubit = args["profileCubit"] as ProfileCubit;
    globalCubit = args["globalCubit"] as GlobalCubit;

    return BlocProvider<GlobalCubit>.value(
      value: globalCubit!,
      child: BlocProvider<ProfileCubit>.value(
        value: profileCubit!,
        child: Scaffold(
          appBar:
              CustomAppBar(followingsList: tags!.map((e) => e.last).toList()),
          body: Builder(
            builder: (context) {
              final isEmptyFollowings = (tags ?? []).isEmpty;

              if (isEmptyFollowings) {
                return const EmptyList();
              } else {
                return UsersListToFollow(
                  pubKeys: tags!.map((e) => e.last).toList(),
                  noBg: true,
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
