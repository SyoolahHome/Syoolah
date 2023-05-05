import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../buisness_logic/profile/profile_cubit.dart';

class AvatarSheetWidget extends StatelessWidget {
  const AvatarSheetWidget({
    super.key,
    required this.onPickFromGallery,
    required this.onTakePhoto,
    required this.onRemove,
    required this.onEnd,
    required this.onAvatarPickedOrTaken,
    required this.cubitContext,
    required this.cubit,
    required this.onFullView,
  });
  final BuildContext cubitContext;
  final Future<void> Function() onPickFromGallery;
  final Future<void> Function() onTakePhoto;
  final Future<void> Function() onRemove;
  final Future<void> Function() onEnd;
  final Future<bool> Function() onAvatarPickedOrTaken;
  final void Function() onFullView;
  final BlocBase cubit;
  @override
  Widget build(BuildContext context) {
    assert(cubit is ProfileCubit);

    return BlocProvider<ProfileCubit>.value(
      value: cubit as ProfileCubit,
      child: Builder(builder: (context) {
        return BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                AnimatedCrossFade(
                  duration: const Duration(milliseconds: 300),
                  crossFadeState: state.isLoading
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  secondChild: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: const Center(
                      child: SizedBox(
                        height: 30,
                        width: 30,
                        child: CircularProgressIndicator(
                          strokeWidth: 1.25,
                        ),
                      ),
                    ),
                  ),
                  firstChild: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ListTile(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20),
                        leading: const Icon(FlutterRemix.image_2_line),
                        title: Text("fullImageView".tr()),
                        onTap: onFullView,
                      ),
                      ListTile(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20),
                        leading: const Icon(FlutterRemix.camera_2_line),
                        title: Text("takeFromCamera".tr()),
                        onTap: () {
                          onTakePhoto()
                              .then((_) => onAvatarPickedOrTaken())
                              .then((isUploaded) {
                            if (isUploaded) {
                              onEnd();
                            }
                          });
                        },
                      ),
                      ListTile(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20),
                        leading: const Icon(FlutterRemix.gallery_line),
                        title: Text("takeFromGallery".tr()),
                        onTap: () {
                          onPickFromGallery()
                              .then((_) => onAvatarPickedOrTaken())
                              .then((isUploaded) {
                            if (isUploaded) {
                              onEnd();
                            }
                          });
                        },
                      ),
                      ListTile(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20),
                        leading: const Icon(FlutterRemix.delete_bin_2_line),
                        title: Text("removeAvatar".tr()),
                        onTap: () {
                          onRemove().then((_) => onEnd());
                        },
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      }),
    );
  }
}
