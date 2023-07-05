import 'package:ditto/buisness_logic/profile/profile_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

class ImageUpdateSheetWidget extends StatelessWidget {
  const ImageUpdateSheetWidget({
    super.key,
    required this.onPickFromGallery,
    required this.onTakePhoto,
    required this.onRemove,
    required this.onEnd,
    required this.onPickedOrTaken,
    required this.cubitContext,
    required this.cubit,
    required this.onFullView,
  });

  factory ImageUpdateSheetWidget.avatar({
    required BuildContext cubitContext,
    required Future<void> Function() onPickFromGallery,
    required Future<void> Function() onTakePhoto,
    required Future<void> Function() onRemove,
    required Future<void> Function() onEnd,
    required Future<bool> Function() onAvatarPickedOrTaken,
    required void Function() onFullView,
    required BlocBase cubit,
  }) {
    return ImageUpdateSheetWidget(
      onPickFromGallery: onPickFromGallery,
      onTakePhoto: onTakePhoto,
      onRemove: onRemove,
      onEnd: onEnd,
      onPickedOrTaken: onAvatarPickedOrTaken,
      cubitContext: cubitContext,
      cubit: cubit,
      onFullView: onFullView,
    );
  }

  factory ImageUpdateSheetWidget.banner({
    required Future<void> Function() onPickFromGallery,
    required Future<void> Function() onTakePhoto,
    required Future<void> Function() onRemove,
    required Future<void> Function() onEnd,
    required Future<bool> Function() onBannerPickedOrTaken,
    required BuildContext cubitContext,
    required void Function() onFullView,
    required BlocBase cubit,
  }) {
    return ImageUpdateSheetWidget(
      onPickFromGallery: onPickFromGallery,
      onTakePhoto: onTakePhoto,
      onRemove: onRemove,
      onEnd: onEnd,
      onPickedOrTaken: onBannerPickedOrTaken,
      cubitContext: cubitContext,
      cubit: cubit,
      onFullView: onFullView,
    );
  }

  final BuildContext cubitContext;
  final Future<void> Function() onPickFromGallery;
  final Future<void> Function() onTakePhoto;
  final Future<void> Function() onRemove;
  final Future<void> Function() onEnd;
  final Future<bool> Function() onPickedOrTaken;
  final void Function() onFullView;
  final BlocBase cubit;

  @override
  Widget build(BuildContext context) {
    assert(cubit is ProfileCubit);

    return BlocProvider<ProfileCubit>.value(
      value: cubit as ProfileCubit,
      child: Builder(
        builder: (context) {
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
                      children: AnimateList(
                        effects: <Effect>[const FadeEffect()],
                        interval: 100.ms,
                        children: <Widget>[
                          ListTile(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 20),
                            leading: Icon(
                              FlutterRemix.image_2_line,
                              color: Theme.of(context).iconTheme.color,
                              size: 19,
                            ),
                            title: Text(
                              "fullImageView".tr(),
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            onTap: onFullView,
                          ),
                          ListTile(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 20),
                            leading: Icon(
                              FlutterRemix.camera_2_line,
                              color: Theme.of(context).iconTheme.color,
                              size: 19,
                            ),
                            title: Text(
                              "takeFromCamera".tr(),
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            onTap: () {
                              onTakePhoto()
                                  .then((_) => onPickedOrTaken())
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
                            leading: Icon(
                              FlutterRemix.gallery_line,
                              color: Theme.of(context).iconTheme.color,
                              size: 19,
                            ),
                            title: Text(
                              "takeFromGallery".tr(),
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            onTap: () {
                              onPickFromGallery()
                                  .then((_) => onPickedOrTaken())
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
                            leading: Icon(
                              FlutterRemix.delete_bin_2_line,
                              color: Theme.of(context).iconTheme.color,
                              size: 19,
                            ),
                            title: Text(
                              "delete".tr(),
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            onTap: () {
                              onRemove().then((_) => onEnd());
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
