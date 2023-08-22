import 'package:bloc/bloc.dart';
import 'package:ditto/model/chat_modules.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';

import '../../constants/app_configs.dart';

part 'chat_modules_state.dart';

/// {@template chat_modules_cubit}
/// The responsible cubit for the chat modules UI that will enable to select and configure the Imam
/// {@endtemplate}
class ChatModulesCubit extends Cubit<ChatModulesState> {
  /// The responsible controller for the chat modules UI that will respond to the [state.sliderValue] to show it.
  PageController? pageController;

  /// {@macro chat_modules_cubit}
  ChatModulesCubit() : super(ChatModulesInitial()) {
    _init();
  }

  @override
  Future<void> close() {
    pageController?.dispose();

    return super.close();
  }

  /// A list of available and allowed chat modules that will be shown in the UI.
  List<ChatModuleItem> get modulesItems => <ChatModuleItem>[
        ChatModuleItem.beginner(
          subtitle:
              "This will guide you with all information about islam" /* ??
              "chatInstructorSubtitle".tr() */
          ,
          icon: FlutterIslamicIcons.solidKowtow,
          instruction:
              "You are an islamic imam who will guide with all information about islam",
          recommendedQuestions: AppConfigs.beginnerRecommendedQuestions,
        ),
        ChatModuleItem.intermediate(
          subtitle:
              "This will guide you with all information about seerah of Prophet Muhammad (PBUH)" /* ??
                  "chatInstructorSubtitle".tr() */
          ,
          icon: FlutterIslamicIcons.solidMosque,
          instruction:
              "You are an islamic imam who will guide with all information about seerah of Prophet Muhammad (PBUH)",
          recommendedQuestions: AppConfigs.intermediateRecommendQuestions,
        ),
        ChatModuleItem.advanced(
          subtitle: "chatInstructorSubtitle".tr(),
          icon: FlutterIslamicIcons.solidQuran2,
          instruction:
              "You are an islamic imam who will guide with all information about islam",
          recommendedQuestions: AppConfigs.advancedRecommendQuestions,
        ),
      ];

  /// emit the new slider state to be shown in the UI.
  void changeSliderValue(double value) {
    emit(state.copyWith(sliderValue: value));

    pageController!.animateToPage(
      value.toInt(),
      duration: Animate.defaultDuration,
      curve: Curves.easeInOut,
    );
  }

  void _init() {
    pageController = PageController(
      initialPage: state.sliderValue.toInt(),
      viewportFraction: 0.7,
    );
  }
}
