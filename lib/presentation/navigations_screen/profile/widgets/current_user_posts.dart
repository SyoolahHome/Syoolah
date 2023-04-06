import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../buisness_logic/profile/profile_cubit.dart';

class CurrentUserPosts extends StatelessWidget {
  const CurrentUserPosts({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Column(
          children: state.currentUserPosts.map((event) {
            return Text(event.content);
          }).toList(),
        );
      },
    );
  }
}
