import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditto/model/user_meta_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../buisness_logic/profile/profile_cubit.dart';
import '../../../general/widget/note_card/wudgets/image_full_view..dart';

class ProfileBanner extends StatelessWidget {
  const ProfileBanner({
    super.key,
    required this.metadata,
    required this.child,
  });

  final UserMetaData metadata;

  final Widget child;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileCubit>();
    return child;

    Future<void> onFullView() async {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ImageFullView(
            link: metadata.banner!,
            heroTag: metadata.banner!,
          ),
        ),
      );
    }

    return GestureDetector(
      onLongPress: () {
        context.read<ProfileCubit>().showBannerMenu(
          context,
          cubit: cubit,
          onEnd: () {
            return Future.delayed(
              const Duration(milliseconds: 300),
              () {
                if (ModalRoute.of(context)?.isCurrent != true) {
                  Navigator.of(context).pop();
                }
              },
            );
          },
          onFullView: onFullView,
        );
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
          image: metadata.banner != null
              ? DecorationImage(
                  fit: BoxFit.cover,
                  image: CachedNetworkImageProvider(
                    cacheKey: metadata.banner!,
                    metadata.banner!,
                  ),
                )
              : null,
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: <Color>[
                Theme.of(context).colorScheme.onBackground,
                Colors.transparent,
              ],
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
