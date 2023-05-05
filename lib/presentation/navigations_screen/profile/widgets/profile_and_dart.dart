import 'package:ditto/buisness_logic/global/global_cubit.dart';
import 'package:ditto/buisness_logic/profile/profile_cubit.dart';
import 'package:ditto/model/user_meta_data.dart';
import 'package:ditto/presentation/navigations_screen/profile/widgets/follow_info.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../services/utils/paths.dart';
import 'avatar_layers.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.metadata,
  });

  final UserMetaData metadata;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        BlocBuilder<GlobalCubit, GlobalState>(
          builder: (context, state) {
            return FollowInfo(
              label: "followings".tr(),
              count: state.currentUserFollowing?.tags.length ?? 0,
              onTap: () {
                final profileCubit = context.read<ProfileCubit>();
                final globalCubit = context.read<GlobalCubit>();

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
        AvatarLayers(metadata: metadata),
        BlocBuilder<GlobalCubit, GlobalState>(
          builder: (context, state) {
            return FollowInfo(
              label: "followers".tr(),
              count: state.currentUserFollowers?.tags.length ?? 0,
              onTap: () {
                Navigator.of(context).pushNamed(Paths.followers);
              },
            );
          },
        ),
      ],
    );
  }
}
