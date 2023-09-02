import 'package:ditto/buisness_logic/global/global_cubit.dart';
import 'package:ditto/buisness_logic/profile/profile_cubit.dart';
import 'package:ditto/model/user_meta_data.dart';
import 'package:ditto/presentation/navigations_screen/profile/widgets/avatar_layers.dart';
import 'package:ditto/presentation/navigations_screen/profile/widgets/follow_info.dart';
import 'package:ditto/services/nostr/nostr_service.dart';
import 'package:ditto/services/utils/paths.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../buisness_logic/user_follow/user_follows_cubit.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.metadata,
  });

  final UserMetaData metadata;

  @override
  Widget build(BuildContext context) {
    final profileCubit = context.read<ProfileCubit>();
    final globalCubit = context.read<GlobalCubit>();
    final isCurrentUser = profileCubit.isCurrentUser;

    if (isCurrentUser) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Animate(
            effects: const [FadeEffect()],
            delay: 600.ms,
            child: BlocBuilder<GlobalCubit, GlobalState>(
              builder: (context, state) {
                return FollowInfo(
                  label: "following".tr(),
                  count: state.currentUserFollowing?.tags.length ?? 0,
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      Paths.followings,
                      arguments: {
                        "tags": state.currentUserFollowing?.tags ?? [],
                        "profileCubit": profileCubit,
                        "globalCubit": globalCubit,
                      },
                    );
                  },
                );
              },
            ),
          ),
          AvatarLayers(metadata: metadata),
          Animate(
            effects: const [FadeEffect()],
            delay: 600.ms,
            child: BlocBuilder<GlobalCubit, GlobalState>(
              builder: (context, state) {
                return FollowInfo(
                  label: "followers".tr(),
                  count: state.currentUserFollowers.length,
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      Paths.followers,
                      arguments: {
                        "userFollowersEvents": state.currentUserFollowers,
                        "profileCubit": profileCubit,
                        "globalCubit": globalCubit,
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      );
    } else {
      final userPubKey = metadata.userMetadataEvent?.pubkey;
      if (userPubKey == null) {
        return Container();
      }

      return BlocProvider<UserFollowsCubit>(
        create: (context) => UserFollowsCubit(
          userPubKey: metadata.userMetadataEvent!.pubkey,
          userFollowersNostrStream: NostrService.instance.subs.userFollowers(
            userPubKey: userPubKey,
          ),
          userFollowingsNostrStream: NostrService.instance.subs.userFollowings(
            userPubKey: userPubKey,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Animate(
              effects: const [FadeEffect()],
              delay: 600.ms,
              child: BlocBuilder<UserFollowsCubit, UserFollowsState>(
                builder: (context, state) {
                  return FollowInfo(
                    label: "following".tr(),
                    count: state.userFollowingEvent?.tags.length ?? 0,
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        Paths.followings,
                        arguments: {
                          "tags": state.userFollowingEvent?.tags ?? [],
                          "profileCubit": profileCubit,
                          "globalCubit": globalCubit,
                        },
                      );
                    },
                  );
                },
              ),
            ),
            AvatarLayers(metadata: metadata),
            Animate(
              effects: const [FadeEffect()],
              delay: 600.ms,
              child: BlocBuilder<UserFollowsCubit, UserFollowsState>(
                builder: (context, state) {
                  return FollowInfo(
                    label: "followers".tr(),
                    count: state.userFollowersEvents.length,
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        Paths.followers,
                        arguments: {
                          "userFollowersEvents": state.userFollowersEvents,
                          "profileCubit": profileCubit,
                          "globalCubit": globalCubit,
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      );
    }
  }
}
