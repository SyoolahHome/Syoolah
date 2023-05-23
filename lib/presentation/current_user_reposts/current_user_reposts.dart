import 'dart:convert';

import 'package:ditto/buisness_logic/cubit/current_user_reposts_cubit.dart';
import 'package:ditto/model/note.dart';
import 'package:ditto/presentation/feeds/widgets/notes_list_view.dart';
import 'package:ditto/services/nostr/nostr_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrentUserReposts extends StatelessWidget {
  const CurrentUserReposts({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CurrentUserRepostsCubit>(
      create: (context) => CurrentUserRepostsCubit(
        currentUserReposts: NostrService.instance.currentUserReposts(),
      ),
      child: Builder(
        builder: (context) {
          return BlocBuilder<CurrentUserRepostsCubit, CurrentUserRepostsState>(
            builder: (context, state) {
              return NotesListView(
                shrinkWrap: true,
                feedName: "takes".tr(),
                endTitleWithAdditionalText: false,
                hideCount: true,
                physics: const NeverScrollableScrollPhysics(),
                notes: state.currentUserReposts
                    .map((e) => Note.fromJson(
                        jsonDecode(e.content) as Map<String, dynamic>))
                    .toList(),
              );
            },
          );
        },
      ),
    );
  }
}
