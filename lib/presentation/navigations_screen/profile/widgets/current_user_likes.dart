import 'package:ditto/buisness_logic/profile/profile_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrentUserLikes extends StatelessWidget {
  const CurrentUserLikes({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Column(
          children: state.currentUserLikedPosts
              .map(
                (e) => Text(e.pubkey),
              )
              .toList(),
        );
      },
    );
  }
}
