import 'package:ditto/buisness_logic/profile/profile_cubit.dart';
import 'package:ditto/model/user_meta_data.dart';
import 'package:ditto/presentation/general/widget/note_card/wudgets/image_full_view..dart';
import 'package:ditto/presentation/navigations_screen/profile/widgets/avatar.dart';
import 'package:ditto/presentation/navigations_screen/profile/widgets/avatar_border.dart';
import 'package:ditto/presentation/navigations_screen/profile/widgets/avatar_neon.dart';
import 'package:ditto/presentation/navigations_screen/profile/widgets/avatar_neon_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AvatarLayers extends StatelessWidget {
  const AvatarLayers({
    super.key,
    required this.metadata,
  });
  final UserMetaData metadata;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileCubit>();

    Future<void> onFullView() async {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ImageFullView(
            link: metadata.picture!,
            heroTag: metadata.picture!,
          ),
        ),
      );
    }

    return Animate(
      effects: const [FadeEffect()],
      delay: 200.ms,
      child: GestureDetector(
        onPanDown: (_) => cubit.scaleAvatarDown(),
        onPanStart: (_) => cubit.scaleAvatarDown(),
        onPanCancel: () => cubit.scaleAvatarToNormal(),
        onPanEnd: (_) => cubit.scaleAvatarToNormal(),
        onTap: onFullView,
        onLongPress: () {
          cubit.showAvatarMenu(
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
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            return Stack(
              alignment: Alignment.center,
              children: <Widget>[
                const ProfileAvatarNeon(),
                const ProfileAvatarNeonBorder(),
                const ProfileAvatarBorder(),
                AnimatedScale(
                  duration: const Duration(milliseconds: 300),
                  scale: state.profileAvatarScale,
                  child: ProfileAvatar(picture: metadata.picture!),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
