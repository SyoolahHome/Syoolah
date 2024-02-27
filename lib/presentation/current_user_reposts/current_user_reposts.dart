import 'dart:convert';
import 'package:ditto/model/note.dart';
import 'package:ditto/presentation/feeds/widgets/notes_list_view.dart';
import 'package:ditto/services/nostr/nostr_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../buisness_logic/current_user_reposts/current_user_reposts_cubit.dart';
import '../../constants/abstractions/abstractions.dart';

class CurrentUserReposts extends UserProfileTab {
  CurrentUserReposts({
    super.key,
    required super.userPubKey,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CurrentUserRepostsCubit>(
      create: (context) => CurrentUserRepostsCubit(
        currentUserReposts: NostrService.instance.subs.userReposts(
          userPubKey: userPubKey,
        ),
      ),
      child: Builder(
        builder: (context) {
          return BlocBuilder<CurrentUserRepostsCubit, CurrentUserRepostsState>(
            builder: (context, state) {
              return NotesListView(
                shrinkWrap: true,
                // feedName: "takes".tr(),
                showLoadingIndicator: state.shouldShowLoadingIndicator,
                endTitleWithAdditionalText: false,
                hideCount: true,
                physics: const NeverScrollableScrollPhysics(),
                notes: state.currentUserReposts.map(
                  (e) {
                    final decoded =
                        jsonDecode(e.content) as Map<String, dynamic>;

                    return Note.fromJson(
                      decoded,
                    );
                  },
                ).toList(),
              );
            },
          );
        },
      ),
    );
  }
}
