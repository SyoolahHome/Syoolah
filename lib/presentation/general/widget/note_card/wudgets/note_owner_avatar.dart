import 'package:ditto/buisness_logic/global/global_cubit.dart';
import 'package:ditto/presentation/general/custom_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../buisness_logic/bottom_bar/bottom_bar_cubit.dart';
import '../../../../../services/utils/routing.dart';
import '../../../../navigations_screen/profile/profile.dart';

class NoteOwnerAvatar extends StatelessWidget {
  const NoteOwnerAvatar({
    super.key,
    required this.avatarUrl,
    this.size,
    this.userPubKey,
  });

  final String avatarUrl;
  final double? size;
  final String? userPubKey;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (userPubKey != null) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) {
                return MultiBlocProvider(
                  providers: [
                    BlocProvider<BottomBarCubit>.value(
                      value: Routing.bottomBarCubit,
                    ),
                    BlocProvider<GlobalCubit>.value(
                      value: context.read<GlobalCubit>(),
                    ),
                  ],
                  child: Profile(userPubKey: userPubKey!),
                );
              },
            ),
          );
        }
      },
      child: Transform.scale(
        scale: size != null ? size! / 40 : 1,
        child: Container(
          clipBehavior: Clip.hardEdge,
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          child: CustomCachedNetworkImage(
            url: avatarUrl,
            shouldOpenFullViewOnTap: false,
          ),
        ),
      ),
    );
  }
}
