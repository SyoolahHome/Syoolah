import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dart_nostr/dart_nostr.dart';
import 'package:ditto/presentation/onboarding/widgets/animated_logo.dart';
import 'package:ditto/services/bottom_sheet/bottom_sheet_service.dart';
import 'package:ditto/services/utils/extensions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:image_picker/image_picker.dart';
import '../../model/sign_up_step_view.dart';
import '../../model/user_meta_data.dart';
import '../../presentation/general/text_field.dart';
import '../../presentation/private_succes/widgets/key_section.dart';
import '../../presentation/sign_up/widgets/avatar_upload.dart';
import '../../presentation/sign_up/widgets/users_list_to_follow.dart';
import '../../services/database/local/local_database.dart';
import '../../services/nostr/nostr_service.dart';
import '../../services/utils/app_utils.dart';
import '../../services/utils/file_upload.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  PageController? pageController;
  TextEditingController? nameController;
  TextEditingController? existentKeyController;
  TextEditingController? bioController;
  TextEditingController? usernameController;
  TextEditingController? nip05Controller;
  FocusNode? nameFocusNode;

  AuthCubit() : super(const AuthInitial()) {
    _init();
  }

  Future<void> authenticate() async {
    try {
      await _generatePrivateKeyAndSetInfoToNostr();
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
        ),
      );
      emit(state.copyWith(authenticated: true));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    } finally {
      emit(state.copyWith(error: null));
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
    nip05Controller?.dispose();

    return super.close();
  }

  Future<void> handleExistentKey() async {
    final existentKey = existentKeyController?.text ?? '';
    if (existentKey.isEmpty) {
      emit(state.copyWith(error: "pleaseEnterKey".tr()));

      return;
    }
    if (!Nostr.instance.keysService.isValidPrivateKey(existentKey)) {
      emit(state.copyWith(error: "invalidKey".tr()));

      return;
    }

    try {
      final keyChain = NostrKeyPairs(private: existentKey);
      LocalDatabase.instance.setPrivateKey(keyChain.private);
      emit(state.copyWith(authenticated: true));
    } catch (e) {
      emit(state.copyWith(error: "invalidKey".tr()));

      return;
    } finally {
      emit(state.copyWith(error: null));
    }
  }

  void signOut() {
    LocalDatabase.instance.setPrivateKey(null);
    emit(state.copyWith(isSignedOut: true));
  }

  void copyPrivateKey() {
    try {
      Clipboard.setData(
        ClipboardData(text: LocalDatabase.instance.getPrivateKey()),
      );
    } catch (e) {
      emit(state.copyWith(error: "couldNotCopyKey".tr()));
    }
  }

  void gotoNext() {
    final _internalPageController = pageController;
    if (_internalPageController == null) {
      return;
    }
    final _internalPageControllerPage = _internalPageController.page;
    if (_internalPageControllerPage == null) {
      return;
    }

    if (_internalPageControllerPage.round() + 1 < signUpScreens.length) {
      _internalPageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void previousStep() {
    final _internalPageController = pageController;
    if (_internalPageController == null) {
      return;
    }
    final _internalPageControllerPage = _internalPageController.page;
    if (_internalPageControllerPage == null) {
      return;
    }

    if (_internalPageControllerPage.round() - 1 >= 0) {
      _internalPageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> pickImage() async {
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
      emit(state.copyWith(error: null, pickedImage: state.pickedImage));
    }
  }

  Future<void> _generatePrivateKeyAndSetInfoToNostr() async {
    emit(state.copyWith(isGeneratingNewPrivateKey: true));
    final name = nameController?.text ?? '';
    if (name.isEmpty) {
      emit(state.copyWith(
        isGeneratingNewPrivateKey: false,
      ));
      throw "pleaseEnterName".tr();
    }

    final newGeneratedPair = NostrKeyPairs.generate();
    final privateKey = newGeneratedPair.private;

    await LocalDatabase.instance.setAuthInformations(
      key: privateKey,
      name: name,
    );

    emit(state.copyWith(isGeneratingNewPrivateKey: false));
  }

  void _init() {
    pageController = PageController()
      ..addListener(() {
        final _internalPageController = pageController;
        if (_internalPageController == null) {
          return;
        }
        final _internalPageControllerPage = _internalPageController.page;
        if (_internalPageControllerPage == null) {
          return;
        }

        emit(
          state.copyWith(
            currentStepIndex: _internalPageControllerPage.round() + 1,
          ),
        );
      });
    nameController = TextEditingController();
    bioController = TextEditingController();
    usernameController = TextEditingController();
    nip05Controller = TextEditingController();

    if (kDebugMode) {
      nameController?.text = 'test name';
    }
    existentKeyController = TextEditingController();
    nameFocusNode = FocusNode();
  }

  List<SignUpStepView> get signUpScreens => <SignUpStepView>[
        SignUpStepView(
          title: "welcome".tr(),
          subtitle: "welcomeSubtitle".tr(),
          widgetBody: const Center(
            child: MunawarahLogo(
              width: 140,
              isHero: false,
            ),
          ),
          nextViewAllower: () {
            return true;
          },
        ),
        SignUpStepView(
          title: "whatIsYourName".tr(),
          subtitle: "whatIsYourNameSubtitle".tr(),
          widgetBody: CustomTextField(
            controller: nameController,
            label: "yourName".tr(),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          ),
          nextViewAllower: () {
            final fullName = nameController?.text ?? '';

            usernameController!.text = "@${fullName.split(' ').join('_')}";
            final minAcceptableUsernameLength = 2;

            return usernameController!.text.isNotEmpty &&
                usernameController!.text.length >= minAcceptableUsernameLength;
          },
        ),
        SignUpStepView(
          title: "whatAboutYou".tr(),
          subtitle: "whatAboutYouSubtitle".tr(),
          widgetBody: CustomTextField(
            controller: bioController,
            label: "recommendedOneLines".tr(),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            isMultiline: true,
          ),
          nextViewAllower: () {
            final bio = bioController?.text ?? '';

            return bio.isNotEmpty;
          },
        ),
        SignUpStepView(
          title: "yourProfileImage".tr(),
          subtitle: "yourProfileImageSubtitle".tr(),
          widgetBody: const Center(child: AvatarUpload()),
          nextViewAllower: () {
            return true;
          },
        ),
        SignUpStepView(
          title: "yourUsername".tr(),
          subtitle: "yourUsernameSubtitle".tr(),
          widgetBody: CustomTextField(
            controller: usernameController,
            label: "yourUsername".tr(),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            hint: "hintUsername".tr(),
          ),
          nextViewAllower: () {
            final username = usernameController?.text ?? '';

            return username.isNotEmpty;
          },
          onButtonTap: () {
            authenticate();
          },
        ),
        SignUpStepView(
          title: "NIP05IdentifierTitle".tr(),
          subtitle: "NIP05IdentifierSubtitle".tr(),
          widgetBody: CustomTextField(
            controller: nip05Controller,
            label: "yourNIP05".tr(),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            hint: "hintNIP05".tr(),
          ),
          nextViewAllower: () {
            // TODO: implement nip05 validator and check if it's valid.
            final isValidNIP05 = true;
            return nip05Controller!.text.isNotEmpty && isValidNIP05;
          },
          // onButtonTap: () {},
        ),
        SignUpStepView(
          title: "yourPrivateKey".tr(),
          subtitle: "yourPrivateKeySubtitle".tr(),
          widgetBody: Builder(
            builder: (context) {
              final iconColorOpacity = 0.05;

              return Center(
                child: IconButton(
                  padding: const EdgeInsets.all(15),
                  onPressed: () {
                    final val =
                        BottomSheetService.showPrivateKeyGenSuccess(context);
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
            return true;
          },
        ),
        SignUpStepView(
          title: "yourPublicKey".tr(),
          subtitle: "yourPublicKeySubtitle".tr(),
          widgetBody: const KeySection(type: KeySectionType.publicKey),
          nextViewAllower: () {
            return true;
          },
        ),
        SignUpStepView(
          title: "recommendToFollow".tr(),
          subtitle: "yourPublicKeySubtitle".tr(),
          widgetBody: const UsersListToFollow(
            pubKeys: <String>[
              "32e1827635450ebb3c5a7d12c1f8e7b2b514439ac10a67eef3d9fd9c5c68e245",
              "3bf0c63fcb93463407af97a5e5ee64fa883d107ef9e558472c4eb9aaaefa459d",
              "1577e4599dd10c863498fe3c20bd82aafaf829a595ce83c5cf8ac3463531b09b",
            ],
          ),
          nextViewAllower: () {
            return true;
          },
        ),
      ];
}
