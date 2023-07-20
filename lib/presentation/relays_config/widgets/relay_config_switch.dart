import 'package:ditto/buisness_logic/app/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../services/utils/routing.dart';

class RelayConfigSwitch extends StatelessWidget {
  const RelayConfigSwitch({
    super.key,
    required this.value,
    required this.index,
  });

  final bool value;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.65,
      child: Switch(
        onChanged: (value) {
          context.read<AppCubit>().selectRelay(index: index, isActive: value);
        },
        value: value,
      ),
    );
  }
}
