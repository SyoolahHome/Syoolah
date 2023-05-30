import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dart_nostr/dart_nostr.dart';
import 'package:ditto/model/sign_up_step_view.dart';
import 'package:ditto/model/user_meta_data.dart';
import 'package:ditto/presentation/general/text_field.dart';
import 'package:ditto/presentation/private_succes/widgets/key_section.dart';
import 'package:ditto/presentation/sign_up/widgets/avatar_upload.dart';
import 'package:ditto/services/bottom_sheet/bottom_sheet_service.dart';
import 'package:ditto/services/database/local/local_database.dart';
import 'package:ditto/services/nostr/nostr_service.dart';
import 'package:ditto/services/utils/file_upload.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:image_picker/image_picker.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  PageController? pageController;
  TextEditingController? nameController;
  TextEditingController? existentKeyController;
  TextEditingController? bioController;
  TextEditingController? usernameController;
  FocusNode? nameFocusNode;

  AuthCubit() : super(const AuthInitial()) {
    _init();
  }

  Future<void> authenticate() async {
    try {
      String? imageLink;
      final pickedImage = state.pickedImage;

      if (pickedImage != null) {
        imageLink = await FileUpload()(pickedImage);
      }

      NostrService.instance.setCurrentUserMetaData(
        metadata: UserMetaData(
          name: nameController?.text ?? '',
          picture: imageLink,
          banner: null,
          username: usernameController?.text ?? '',
          about: bioController?.text ?? '',
          displayName: nameController?.text.split(" ").join("-") ?? '',
          nip05Identifier: '',
        ),
      );
      emit(
        state.copyWith(
          authenticated: true,
          pickedImage: state.pickedImage,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          error: e.toString(),
          pickedImage: state.pickedImage,
        ),
      );
    } finally {
      emit(
        state.copyWith(
          pickedImage: state.pickedImage,
        ),
      );
    }
  }

  @override
  Future<void> close() {
    nameController?.dispose();
    nameFocusNode?.dispose();
    pageController?.dispose();
    bioController?.dispose();
    usernameController?.dispose();
    existentKeyController?.dispose();

    return super.close();
  }

  Future<void> handleExistentKey() async {
    final existentKey = existentKeyController?.text ?? '';
    if (existentKey.isEmpty) {
      emit(
        state.copyWith(
          error: "pleaseEnterKey".tr(),
          pickedImage: state.pickedImage,
        ),
      );

      return;
    }
    if (!Nostr.instance.keysService.isValidPrivateKey(existentKey)) {
      emit(
        state.copyWith(
          error: "invalidKey".tr(),
          pickedImage: state.pickedImage,
        ),
      );

      return;
    }

    try {
      final keyChain = NostrKeyPairs(private: existentKey);
      await LocalDatabase.instance.setPrivateKey(keyChain.private);
      emit(
        state.copyWith(
          authenticated: true,
          pickedImage: state.pickedImage,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          error: "invalidKey".tr(),
          pickedImage: state.pickedImage,
        ),
      );
    } finally {
      emit(state.copyWith(pickedImage: state.pickedImage));
    }
  }

  void signOut() {
    LocalDatabase.instance.setPrivateKey(null);
    emit(
      state.copyWith(
        isSignedOut: true,
        pickedImage: state.pickedImage,
      ),
    );
  }

  void copyPrivateKey() {
    try {
      Clipboard.setData(
        ClipboardData(text: LocalDatabase.instance.getPrivateKey() ?? ""),
      );
    } catch (e) {
      emit(
        state.copyWith(
          error: "couldNotCopyKey".tr(),
          pickedImage: state.pickedImage,
        ),
      );
    }
  }

  void gotoNext() {
    final internalPageController = pageController;
    if (internalPageController == null) {
      return;
    }
    final internalPageControllerPage = internalPageController.page;
    if (internalPageControllerPage == null) {
      return;
    }

    if (internalPageControllerPage.round() + 1 < signUpScreens.length) {
      internalPageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void previousStep() {
    final internalPageController = pageController;
    if (internalPageController == null) {
      return;
    }
    final internalPageControllerPage = internalPageController.page;
    if (internalPageControllerPage == null) {
      return;
    }

    if (internalPageControllerPage.round() - 1 >= 0) {
      internalPageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> pickImageFromGallery() async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
      if (pickedFile != null) {
        final image = File(pickedFile.path);
        emit(
          state.copyWith(pickedImage: image),
        );
      }
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    } finally {
      emit(state.copyWith(pickedImage: state.pickedImage));
    }
  }

  Future<void> pickImageFromCamera() async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: ImageSource.camera,
      );
      if (pickedFile != null) {
        final image = File(pickedFile.path);
        emit(
          state.copyWith(pickedImage: image),
        );
      }
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    } finally {
      emit(state.copyWith(pickedImage: state.pickedImage));
    }
  }

  Future<void> _generatePrivateKeyAndSetInfoToNostr() async {
    emit(state.copyWith(isGeneratingNewPrivateKey: true));
    final name = nameController?.text ?? '';
    if (name.isEmpty) {
      emit(
        state.copyWith(
          isGeneratingNewPrivateKey: false,
        ),
      );

      throw "pleaseEnterName".tr();
    }

    final newGeneratedPair = NostrKeyPairs.generate();
    final privateKey = newGeneratedPair.private;

    await LocalDatabase.instance.setAuthInformations(
      key: privateKey,
      name: name,
    );

    emit(
      state.copyWith(
        isGeneratingNewPrivateKey: false,
        pickedImage: state.pickedImage,
      ),
    );
  }

  void _init() {
    pageController = PageController()
      ..addListener(() {
        final internalPageController = pageController;
        if (internalPageController == null) {
          return;
        }
        final internalPageControllerPage = internalPageController.page;
        if (internalPageControllerPage == null) {
          return;
        }

        emit(
          state.copyWith(
            currentStepIndex: internalPageControllerPage.round() + 1,
            pickedImage: state.pickedImage,
          ),
        );
      });
    nameController = TextEditingController();
    bioController = TextEditingController();
    usernameController = TextEditingController();

    if (kDebugMode) {
      nameController?.text = 'test name';
      bioController?.text = 'test bio';
    }
    existentKeyController = TextEditingController();
    nameFocusNode = FocusNode();
  }

  List<SignUpStepView> get signUpScreens {
    bool isPrivateKeyCopied = false;
    return <SignUpStepView>[
      // SignUpStepView(
      //   title: "welcome".tr(),
      //   subtitle: "welcomeSubtitle".tr(),
      //   widgetBody: const Center(
      //     child: MunawarahLogo(
      //       width: 140,
      //       isHero: false,
      //     ),
      //   ),
      //   nextViewAllower: () {
      //     return Future.value(true);
      //   },
      // ),
      //
      SignUpStepView(
        title: "whatsYourName".tr(),
        subtitle: "whateverYouPutHereWillBeUsedInYourProfile".tr(),
        widgetBody: CustomTextField(
          controller: nameController,
          // label: "yourName".tr(),
          hint: "typeYourName".tr(),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        ),
        nextViewAllower: () {
          final fullName = nameController?.text ?? '';

          usernameController!.text = "@${fullName.split(' ').join('_')}";
          const minAcceptableUsernameLength = 2;

          return Future.value(
            usernameController!.text.isNotEmpty &&
                usernameController!.text.length >= minAcceptableUsernameLength,
          );
        },
      ),
      SignUpStepView(
        title: "bio".tr(),
        subtitle: "addSomethingAboutYouForYourProfileCoupleLines".tr(),
        widgetBody: CustomTextField(
          controller: bioController,
          // label: "recommendedOneLines".tr(),
          hint: "typeYourBio".tr(),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          isMultiline: true,
        ),
        nextViewAllower: () {
          final bio = bioController?.text ?? '';

          return Future.value(bio.isNotEmpty);
        },
      ),
      SignUpStepView(
        title: "yourPhoto".tr(),
        subtitle: "yourPhotoSubtitle".tr(),
        widgetBody: const Center(child: AvatarUpload()),
        nextViewAllower: () {
          return Future.value(true);
        },
      ),
      SignUpStepView(
        title: "addUsername".tr(),
        subtitle: "pickAUsername".tr(),
        widgetBody: CustomTextField(
          controller: usernameController,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
          hint: "typeYourUsername".tr(),
        ),
        nextViewAllower: () {
          final username = usernameController?.text ?? '';

          return Future.value(username.isNotEmpty);
        },
        onButtonTap: () async {
          await _generatePrivateKeyAndSetInfoToNostr();
          // await authenticate();
        },
      ),
      SignUpStepView(
        title: "privateKey".tr(),
        subtitle: "privateKeySubtitle".tr(),
        widgetBody: Builder(
          builder: (context) {
            const iconColorOpacity = 0.05;

            return Center(
              child: IconButton(
                padding: const EdgeInsets.all(15),
                onPressed: () {
                  final val = BottomSheetService.showPrivateKeyGenSuccess(
                    context,
                    onCopy: () {
                      isPrivateKeyCopied = true;
                      Navigator.of(context).pop();
                    },
                    customText: "youNeedToCopyPrivateKey".tr(),
                  );
                },
                style: IconButton.styleFrom(
                  backgroundColor: Theme.of(context)
                      .colorScheme
                      .background
                      .withOpacity(iconColorOpacity),
                ),
                icon: Icon(
                  FlutterRemix.eye_2_line,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
            );
          },
        ),
        nextViewAllower: () {
          return Future.value(isPrivateKeyCopied);
        },
        onButtonTap: () async {
          await authenticate();
        },
      ),
      SignUpStepView(
        title: "publicKey".tr(),
        subtitle: "publicKeySubtitle".tr(),
        widgetBody: const KeySection(type: KeySectionType.publicKey),
        nextViewAllower: () {
          return Future.value(true);
        },
      ),

      // SignUpStepView(
      //   title: "recommendToFollow".tr(),
      //   subtitle: "yourPublicKeySubtitle".tr(),
      //   widgetBody: const UsersListToFollow(
      //     pubKeys: <String>[
      //       "32e1827635450ebb3c5a7d12c1f8e7b2b514439ac10a67eef3d9fd9c5c68e245",
      //       "3bf0c63fcb93463407af97a5e5ee64fa883d107ef9e558472c4eb9aaaefa459d",
      //       "1577e4599dd10c863498fe3c20bd82aafaf829a595ce83c5cf8ac3463531b09b",
      //     ],
      //   ),
      //   nextViewAllower: () {
      //     return Future.value(true);
      //   },
      // ),
    ];
  }

  void removePickedImage() {
    emit(state.copyWith());
  }
}
