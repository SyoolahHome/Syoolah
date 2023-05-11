import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_islamic_icons/flutter_islamic_icons.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../model/chat_modules.dart';

part 'chat_modules_state.dart';

class ChatModulesCubit extends Cubit<ChatModulesState> {
  ChatModulesCubit() : super(ChatModulesInitial());
  List<ChatModuleItem> get modulesItems => <ChatModuleItem>[
        ChatModuleItem(
            title: "General Islam's instructor" ?? "chatInstructorTitle".tr(),
            subtitle: "This will guide you with all information about islam" ??
                "chatInstructorSubtitle".tr(),
            icon: FlutterIslamicIcons.kowtow,
            instruction:
                "You are an islamic imam who will guide with all information about islam",
            recommendedQuestions: [
              "What is islam?",
              "What is the message of islam?",
              "What is the message of the prophet?",
              "What are the five pillars of islam?",
              "What is the name of the last prophet?",
              "How many prophets are there in islam?",
            ]),
        ChatModuleItem(
          title: 'Sirah\s instructor' ?? "chatInstructorTitle".tr(),
          subtitle:
              "This will guide you with all information about Sirah of Prophet Muhammad (PBUH)" ??
                  "chatInstructorSubtitle".tr(),
          icon: FlutterIslamicIcons.solidMuslim,
          instruction:
              "You are an islamic imam who will guide with all information about Sirah of Prophet Muhammad (PBUH)",
          recommendedQuestions: [
            "Who is the prophet of islam?",
            "What is the name of the last prophet?",
            "What is Sirah?",
            "What was the message of the prophet?",
            "Who is the prophet's wifes?",
          ],
        ),
        ChatModuleItem(
          title: "chatInstructorTitle".tr(),
          subtitle: "chatInstructorSubtitle".tr(),
          icon: FlutterRemix.a_b,
          instruction:
              "You are an islamic imam who will guide with all information about islam",
          recommendedQuestions:
              List.generate(7, (index) => "This is the question number $index"),
        ),
        ChatModuleItem(
          title: "chatInstructorTitle".tr(),
          subtitle: "chatInstructorSubtitle".tr(),
          icon: FlutterRemix.a_b,
          instruction:
              "You are an islamic imam who will guide with all information about islam",
          recommendedQuestions:
              List.generate(7, (index) => "This is the question number $index"),
        ),
        ChatModuleItem(
          title: "chatInstructorTitle".tr(),
          subtitle: "chatInstructorSubtitle".tr(),
          icon: FlutterRemix.a_b,
          instruction:
              "You are an islamic imam who will guide with all information about islam",
          recommendedQuestions:
              List.generate(7, (index) => "This is the question number $index"),
        ),
        ChatModuleItem(
          title: "chatInstructorTitle".tr(),
          subtitle: "chatInstructorSubtitle".tr(),
          icon: FlutterRemix.a_b,
          instruction:
              "You are an islamic imam who will guide with all information about islam",
          recommendedQuestions:
              List.generate(7, (index) => "This is the question number $index"),
        ),
        ChatModuleItem(
          title: "chatInstructorTitle".tr(),
          subtitle: "chatInstructorSubtitle".tr(),
          icon: FlutterRemix.a_b,
          instruction:
              "You are an islamic imam who will guide with all information about islam",
          recommendedQuestions:
              List.generate(7, (index) => "This is the question number $index"),
        ),
        ChatModuleItem(
          title: "chatInstructorTitle".tr(),
          subtitle: "chatInstructorSubtitle".tr(),
          icon: FlutterRemix.a_b,
          instruction:
              "You are an islamic imam who will guide with all information about islam",
          recommendedQuestions:
              List.generate(7, (index) => "This is the question number $index"),
        ),
        ChatModuleItem(
          title: "chatInstructorTitle".tr(),
          subtitle: "chatInstructorSubtitle".tr(),
          icon: FlutterRemix.a_b,
          instruction:
              "You are an islamic imam who will guide with all information about islam",
          recommendedQuestions:
              List.generate(7, (index) => "This is the question number $index"),
        ),
      ];
}
