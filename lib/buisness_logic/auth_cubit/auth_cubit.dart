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

import '../../constants/app_enums.dart';
import '../../presentation/privacy/privacy.dart';
import '../../services/utils/app_utils.dart';

part 'auth_state.dart';

/// {@template auth_cubit}
/// The cubit responsible about any authentication process in the app
/// {@endtemplate}
class AuthCubit extends Cubit<AuthState> {
  /// The responsible controller about the steps flow for signing up
  PageController? pageController;

  /// The name text field controller.
  TextEditingController? nameController;

  /// The existent key (for direct auth) text field controller.
  TextEditingController? existentKeyController;

  /// The bio text field controller.
  TextEditingController? bioController;

  /// The username text field controller.
  TextEditingController? usernameController;

  /// The name text field focus node, used to manage the focus while navigating back/to the first flow step.
  FocusNode? nameFocusNode;

  /// {@macro auth_cubit}
  AuthCubit() : super(AuthState.initial()) {
    _init();
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

  /// Authenticates the user with all the collected informations such name, image, bio...
  /// if an avatar image is picked, it will need first to upload it using the file upload service.
  /// Any unspecified field will be replaced with an empty string.
  Future<void> createNewAccount() async {
    try {
      String? imageLink;
      final pickedImage = state.pickedImage;

      final fileUploadService = FileUpload();
      if (pickedImage != null) {
        imageLink = await fileUploadService(pickedImage);
      }

      NostrService.instance.send.setCurrentUserMetaData(
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
      emit(state.copyWith(authenticated: true, pickedImage: state.pickedImage));
    } catch (e) {
      emit(state.copyWith(error: e.toString(), pickedImage: state.pickedImage));
    } finally {
      emit(state.copyWith(pickedImage: state.pickedImage));
    }
  }

  /// Authenticates with an existent set key, works like a login functionality.
  /// if the no key is set or an invalid one, it will will emit an error state.
  Future<void> authenticateWithExistentKey() async {
    final existentKey = existentKeyController?.text ?? '';
    if (existentKey.isEmpty) {
      emit(state.copyWith(
        error: "pleaseEnterKey".tr(),
        pickedImage: state.pickedImage,
      ));

      return;
    }

    if (!Nostr.instance.keysService.isValidPrivateKey(existentKey)) {
      emit(state.copyWith(
        error: "invalidKey".tr(),
        pickedImage: state.pickedImage,
      ));

      return;
    }

    try {
      final keyChain = NostrKeyPairs(private: existentKey);
      final privateKey =
          await LocalDatabase.instance.setPrivateKey(keyChain.private);
      emit(
        state.copyWith(
          privateKey: privateKey,
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
      emit(state.copyWith(
        pickedImage: state.pickedImage,
        error: null,
        authenticated: true,
        privateKey: "",
      ));
    }
  }

  /// Signs Out the current user if any is already authenticated
  void signOut() async {
    assert(
      LocalDatabase.instance.getPrivateKey() != null,
      "There is no point of calling signOut while no user is already authenticated",
    );

    await LocalDatabase.instance.setPrivateKey(null);

    emit(
      state.copyWith(
        isSignedOut: true,
        pickedImage: state.pickedImage,
      ),
    );
  }

  void copyPrivateKey() {
    AppUtils.copy(LocalDatabase.instance.getPrivateKey() ?? "");
  }

  /// Move to the next sign up step during the flow steps.
  /// if the [pageController] is not initialized, it will be ignored.
  /// if the current step page is the last one, it will be ignored.
  void gotoNextSignUpStep({
    Curve animationCurve = Curves.easeInOut,
    Duration animationDuration = const Duration(milliseconds: 300),
  }) {
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
        duration: animationDuration,
        curve: animationCurve,
      );
    }
  }

  /// Moves back to the previous step in the sign up flow.
  /// if the [pageController] is not initialized, it will be ignored.
  /// if the current step is the first one, it will be ignored.
  void goBackToPreviousSignUpStep() {
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

  /// Picks an image from the given [source], saving it in the urrent state
  /// if any error occur, an error state will be handled.
  Future<void> pickImage(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(
        source: source,
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

  /// Picks an image from the gallery, see [pickImage] method.
  Future<void> pickImageFromGallery() {
    return pickImage(ImageSource.gallery);
  }

  /// Picks an image from the camera, see [pickImage] method.
  Future<void> pickImageFromCamera() {
    return pickImage(ImageSource.camera);
  }

  Future<void> _generatePrivateKeyAndSetInfoToNostr() async {
    final name = nameController?.text ?? '';

    emit(state.copyWith(isGeneratingNewPrivateKey: true));

    if (name.isEmpty) {
      emit(state.copyWith(isGeneratingNewPrivateKey: false));

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
    existentKeyController = TextEditingController();

    if (kDebugMode) {
      nameController?.text = 'test name';
      bioController?.text = 'test bio';
    }

    nameFocusNode = FocusNode();
  }

  List<SignUpStepView> get signUpScreens {
    bool isPrivateKeyCopied = false;
    bool isPrivacyPolicyAccepted = false;

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
        title: "privacyAndPolicy".tr(),
        subtitle: "privacyAndPolicyDescription".tr(),
        widgetBody: Center(
            child: PrivacyPolicy(
          shouldShowAcceptSwitchTile: true,
          onAccept: (value) {
            if (value != null) {
              isPrivacyPolicyAccepted = value;
            }
          },
        )),
        nextViewAllower: () {
          return Future.value(isPrivacyPolicyAccepted);
        },
      ),

      SignUpStepView.withOnlyTextField(
        title: "whatsYourName".tr(),
        subtitle: "whateverYouPutHereWillBeUsedInYourProfile".tr(),
        controller: nameController,
        hint: "typeYourName".tr(),
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
      SignUpStepView.withOnlyTextField(
        title: "bio".tr(),
        subtitle: "addSomethingAboutYouForYourProfileCoupleLines".tr(),
        controller: bioController,
        hint: "typeYourBio".tr(),
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
      SignUpStepView.withOnlyTextField(
        title: "addUsername".tr(),
        subtitle: "pickAUsername".tr(),
        controller: usernameController,
        hint: "typeYourUsername".tr(),
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
          await createNewAccount();
        },
      ),
      SignUpStepView.keyShowcase(
        title: "publicKey".tr(),
        subtitle: "publicKeySubtitle".tr(),
        keyType: KeySectionType.publicKey,
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
    emit(state.copyWithNullPickedImage());
  }
}
