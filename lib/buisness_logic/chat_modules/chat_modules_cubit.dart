import 'package:bloc/bloc.dart';
import 'package:ditto/model/chat_modules.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

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
          subtitle: "chatBeginnerSubtitle".tr(),
          imageIcon: "assets/images/f1-car.svg",
          instruction:
              "You are an F1 expert who will answers beginner questions related to F1, its rules & teams..",
          recommendedQuestions: AppConfigs.beginnerRecommendedQuestions,
        ),
        ChatModuleItem.intermediate(
          subtitle: "chatIntermediateSubtitle".tr(),
          imageIcon: "assets/images/f1.svg",
          instruction:
              "You are an F1 expert who will answers intermediate questions related to F1, its rules & teams..",
          recommendedQuestions: AppConfigs.intermediateRecommendQuestions,
        ),
        ChatModuleItem.advanced(
          subtitle: "chatAdvancedSubtitle".tr(),
          imageIcon: "assets/images/win-flag.svg",
          instruction:
              "You are an F1 expert who will answers advanced questions related to F1, its rules & teams..",
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
