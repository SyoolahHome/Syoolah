import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../buisness_logic/zaplocker_dashboard/zaplocker_dashboard_cubit.dart';

class ZaplockerDashboard extends StatelessWidget {
  const ZaplockerDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    final pending = args['pending'] as List;
    final preimages = args['preimages'] as String;
    final v2 = args['v2'] as bool;
    final userData = args['userData'] as Map<String, dynamic>;

    return BlocProvider<ZaplockerDashboardCubit>(
      create: (context) => ZaplockerDashboardCubit(
        userData: userData,
        pending: pending,
        preimages: preimages,
        v2: v2,
      ),
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Pending"),
            ...pending.map((e) => Text(e.toString())),
          ],
        ),
      ),
    );
  }
}
