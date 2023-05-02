import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dart_nostr/dart_nostr.dart';
import 'package:ditto/constants/app_colors.dart';
import 'package:ditto/presentation/onboarding/widgets/animated_logo.dart';
import 'package:ditto/services/bottom_sheet/bottom_sheet_service.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ditto/constants/app_strings.dart';
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
import '../../services/utils/file_upload.dart';
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

    return super.close();
  }

  Future<void> handleExistentKey() async {
    final existentKey = existentKeyController?.text ?? '';
    if (existentKey.isEmpty) {
      emit(state.copyWith(error: AppStrings.pleaseEnterKey));

      return;
    }
    if (!Nostr.instance.keysService.isValidPrivateKey(existentKey)) {
      emit(state.copyWith(error: AppStrings.invalidKey));

      return;
    }

    try {
      final keyChain = NostrKeyPairs(private: existentKey);
      LocalDatabase.instance.setPrivateKey(keyChain.private);
      emit(state.copyWith(authenticated: true));
    } catch (e) {
      emit(state.copyWith(error: AppStrings.invalidKey));

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
      emit(state.copyWith(error: AppStrings.couldNotCopyKey));
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
    final signUpScreens = state.signUpScreens;
    if (signUpScreens == null) {
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
    final signUpScreens = state.signUpScreens;
    if (signUpScreens == null) {
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
      throw AppStrings.pleaseEnterName;
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
        final signUpScreens = state.signUpScreens;
        if (signUpScreens == null) {
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
    if (kDebugMode) {
      nameController?.text = 'test name';
    }
    existentKeyController = TextEditingController();
    nameFocusNode = FocusNode();
    emit(
      AuthInitial(
        signUpScreens: <SignUpStepView>[
          SignUpStepView(
            title: AppStrings.welcome,
            subtitle: AppStrings.welcomeSubtitle,
            widgetBody: const Center(
              child: MunawarahLogo(
                width: 100,
                isHero: false,
              ),
            ),
            nextViewAllower: () {
              return true;
            },
          ),
          SignUpStepView(
            title: AppStrings.whatIsYourName,
            subtitle: AppStrings.whatIsYourNameSubtitle,
            widgetBody: CustomTextField(
              controller: nameController,
              label: AppStrings.yourName,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            ),
            nextViewAllower: () {
              final username = usernameController?.text ?? '';

              usernameController?.text = "@${username.split(' ').join('_')}";
              final minAcceptableUsernameLength = 2;

              return username.isNotEmpty &&
                  username.length >= minAcceptableUsernameLength;
            },
          ),
          SignUpStepView(
            title: AppStrings.whatAboutYou,
            subtitle: AppStrings.whatAboutYouSubtitle,
            widgetBody: CustomTextField(
              controller: bioController,
              label: AppStrings.recommendedOneLines,
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
            title: AppStrings.yourProfileImage,
            subtitle: AppStrings.yourProfileImageSubtitle,
            widgetBody: const Center(child: AvatarUpload()),
            nextViewAllower: () {
              return true;
            },
          ),
          SignUpStepView(
            title: AppStrings.yourUsername,
            subtitle: AppStrings.yourUsernameSubtitle,
            widgetBody: CustomTextField(
              controller: usernameController,
              label: AppStrings.yourUsername,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              hint: AppStrings.hintUsername,
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
            title: AppStrings.yourPrivateKey,
            subtitle: AppStrings.yourPrivateKeySubtitle,
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
                      backgroundColor:
                          AppColors.black.withOpacity(iconColorOpacity),
                    ),
                    icon: const Icon(FlutterRemix.eye_2_line),
                  ),
                );
              },
            ),
            nextViewAllower: () {
              return true;
            },
          ),
          SignUpStepView(
            title: AppStrings.yourPublicKey,
            subtitle: AppStrings.yourPublicKeySubtitle,
            widgetBody: const KeySection(type: KeySectionType.publicKey),
            nextViewAllower: () {
              return true;
            },
          ),
          SignUpStepView(
            title: AppStrings.recommendToFollow,
            subtitle: AppStrings.yourPublicKeySubtitle,
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
        ],
      ),
    );
  }
}
