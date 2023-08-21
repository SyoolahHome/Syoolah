import 'package:dart_nostr/dart_nostr.dart';
import 'package:ditto/buisness_logic/profile/profile_cubit.dart';
import 'package:ditto/presentation/followers/widgets/app_bar.dart';
import 'package:ditto/presentation/followers/widgets/empty_list.dart';
import 'package:ditto/presentation/sign_up/widgets/users_list_to_follow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Followers extends StatelessWidget {
  Followers({super.key});

  List<NostrEvent>? followersEvents;
  ProfileCubit? profileCubit;
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    // todo:
    followersEvents = args["userFollowersEvents"] as List<NostrEvent>;
    profileCubit = args["profileCubit"] as ProfileCubit;

    return BlocProvider<ProfileCubit>.value(
      value: profileCubit!,
      child: Scaffold(
        appBar: CustomAppBar(
            followingsList: followersEvents!.map((e) => e.pubkey).toList()),
        body: Builder(
          builder: (context) {
            final isEmptyFollowings = (followersEvents ?? []).isEmpty;

            if (isEmptyFollowings) {
              return const EmptyList();
            } else {
              return UsersListToFollow(
                pubKeys: followersEvents!.map((e) => e.pubkey).toList(),
                noBg: true,
              );
            }
          },
        ),
      ),
    );
  }
}
