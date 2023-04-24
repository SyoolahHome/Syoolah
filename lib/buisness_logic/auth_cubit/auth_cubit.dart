import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dart_nostr/dart_nostr.dart';
import 'package:ditto/constants/colors.dart';
import 'package:ditto/presentation/onboarding/widgets/animated_logo.dart';
import 'package:ditto/services/bottom_sheet/bottom_sheet.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ditto/constants/strings.dart';
import 'package:flutter_remix/flutter_remix.dart';
import 'package:image_picker/image_picker.dart';
import '../../model/sign_up_view.dart';
import '../../model/user_meta_data.dart';
import '../../presentation/general/text_field.dart';
import '../../presentation/private_succes/widgets/key_section.dart';
import '../../presentation/sign_up/widgets/avatar_upload.dart';
import '../../presentation/sign_up/widgets/users_list_to_follow.dart';
import '../../services/database/local/local.dart';
import '../../services/nostr/nostr.dart';
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
      NostrService.instance.setCurrentUserMetaData(
        metadata: UserMetaData(
          name: nameController!.text,
          username: nameController!.text,
          picture: null,
          banner: null,
          about: null,
        ),
      );
      emit(state.copyWith(authenticated: true));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    } finally {}
  }

  Future<void> _generatePrivateKeyAndSetInfoToNostr() async {
    emit(state.copyWith(isGeneratingNewPrivateKey: true));
    if (nameController!.text.isEmpty) {
      emit(state.copyWith(
        isGeneratingNewPrivateKey: false,
      ));
      throw AppStrings.pleaseEnterName;
    }

    final newGeneratedPair = NostrKeyPairs.generate();
    final privateKey = newGeneratedPair.private;

    await LocalDatabase.instance.setAuthInformations(
      key: privateKey,
      name: nameController!.text,
    );

    emit(state.copyWith(isGeneratingNewPrivateKey: false));
  }

  @override
  Future<void> close() {
    nameController!.dispose();
    nameFocusNode!.dispose();
    pageController!.dispose();
    bioController?.dispose();
    usernameController?.dispose();
    existentKeyController?.dispose();

    return super.close();
  }

  Future<void> handleExistentKey() async {
    if (existentKeyController!.text.isEmpty) {
      emit(state.copyWith(error: AppStrings.pleaseEnterKey));

      return;
    }

    try {
      final keyChain = NostrKeyPairs(private: existentKeyController!.text);
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
    if (pageController!.page!.round() + 1 < state.signUpScreens!.length) {
      pageController!.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void previousStep() {
    if (pageController!.page!.round() - 1 >= 0) {
      pageController!.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _init() {
    pageController = PageController()
      ..addListener(() {
        emit(
          state.copyWith(
            currentStepIndex: pageController!.page!.round() + 1,
          ),
        );
      });
    nameController = TextEditingController();
    bioController = TextEditingController();
    usernameController = TextEditingController();
    if (kDebugMode) {
      nameController!.text = 'test name';
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
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 20,
              ),
              label: AppStrings.yourName,
              controller: nameController!,
            ),
            nextViewAllower: () {
              usernameController!.text =
                  "@${nameController!.text.split(' ').join('_')}";
              return nameController!.text.isNotEmpty &&
                  nameController!.text.length >= 2;
            },
          ),
          SignUpStepView(
            title: AppStrings.whatAboutYou,
            subtitle: AppStrings.whatAboutYouSubtitle,
            widgetBody: CustomTextField(
              isMultiline: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 20,
              ),
              label: AppStrings.recommendedOneLines,
              controller: bioController!,
            ),
            nextViewAllower: () {
              return bioController!.text.isNotEmpty;
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
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 20,
              ),
              label: AppStrings.yourUsername,
              controller: usernameController!,
              hint: AppStrings.hintUsername,
            ),
            nextViewAllower: () {
              return usernameController!.text.isNotEmpty;
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
                return Center(
                  child: IconButton(
                    padding: const EdgeInsets.all(15),
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.black.withOpacity(0.05),
                    ),
                    icon: const Icon(FlutterRemix.eye_2_line),
                    onPressed: () {
                      BottomSheetService.showPrivateKeyGenSuccess(context).then(
                        (_) {
                          // nameFocusNode!.unfocus();
                        },
                      );
                    },
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
}
