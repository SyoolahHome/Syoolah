import 'package:bloc/bloc.dart';
import 'package:ditto/model/chat_modules.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';

part 'chat_modules_state.dart';

class ChatModulesCubit extends Cubit<ChatModulesState> {
  PageController? pageController;

  ChatModulesCubit() : super(ChatModulesInitial()) {
    pageController = PageController(
      initialPage: state.sliderValue.toInt(),
      viewportFraction: 0.7,
    );
  }

  Future<void> close() {
    pageController!.dispose();
    return super.close();
  }

  List<ChatModuleItem> get modulesItems => <ChatModuleItem>[
        ChatModuleItem(
          title: "Beginner" /* ?? "chatInstructorTitle".tr() */,
          subtitle:
              "This will guide you with all information about islam" /* ??
              "chatInstructorSubtitle".tr() */
          ,
          icon: FlutterIslamicIcons.solidKowtow,
          instruction:
              "You are an islamic imam who will guide with all information about islam",
          recommendedQuestions: const [
            "What is islam?",
            "What is the message of islam?",
            "What is the message of the prophet?",
            "What are the five pillars of islam?",
            "What is the name of the last prophet?",
            "How many prophets are there in islam?",
          ],
        ),
        ChatModuleItem(
          title: 'Intermediate' /* ?? "chatInstructorTitle".tr() */,
          subtitle:
              "This will guide you with all information about Sirah of Prophet Muhammad (PBUH)" /* ??
                  "chatInstructorSubtitle".tr() */
          ,
          icon: FlutterIslamicIcons.solidMosque,
          instruction:
              "You are an islamic imam who will guide with all information about Sirah of Prophet Muhammad (PBUH)",
          recommendedQuestions: const [
            "Who is the prophet of islam?",
            "What is the name of the last prophet?",
            "What is Sirah?",
            "What was the message of the prophet?",
            "Who is the prophet's wifes?",
          ],
        ),
        ChatModuleItem(
          title: "Advanced" /* ?? "chatInstructorTitle".tr() */,
          subtitle: "chatInstructorSubtitle".tr(),
          icon: FlutterIslamicIcons.solidQuran2,
          instruction:
              "You are an islamic imam who will guide with all information about islam",
          recommendedQuestions:
              List.generate(7, (index) => "This is the question number $index"),
        ),
      ];

  void changeSliderValue(double value) {
    emit(state.copyWith(sliderValue: value));

    pageController!.animateToPage(
      value.toInt(),
      duration: Animate.defaultDuration,
      curve: Curves.easeInOut,
    );
  }
}
