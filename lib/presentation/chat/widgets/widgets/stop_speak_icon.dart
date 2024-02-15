import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../buisness_logic/chat/chat_cubit.dart';

class StopSpeakingIcon extends StatelessWidget {
  const StopSpeakingIcon({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ChatCubit>();

    return GestureDetector(
      onTap: () {
        cubit.stopSpeaking();
      },
      child: Icon(
        Icons.stop,
        size: 14.0,
        color: Theme.of(context).colorScheme.onSecondary,
      ),
    );
  }
}
