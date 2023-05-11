import 'package:ditto/presentation/feeds/widgets/notes_list_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../buisness_logic/profile/profile_cubit.dart';
import '../../../../model/note.dart';

class CurrentUserReposts extends StatelessWidget {
  const CurrentUserReposts({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return NotesListView(
          shrinkWrap: true,
          feedName: "myReposts".tr(),
          hideCount: true,
          physics: const NeverScrollableScrollPhysics(),
          notes: state.currentUserPosts.map((e) => Note.fromEvent(e)).toList(),
        );
      },
    );
  }
}
