import 'package:ditto/presentation/onboarding/widgets/animated_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../buisness_logic/cubit/nostr_service_loading_cubit.dart';
import '../../services/utils/paths.dart';

class NostrServiceLoading extends StatelessWidget {
  const NostrServiceLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<NostrServiceLoadingCubit>(
        create: (context) => NostrServiceLoadingCubit(),
        child: Builder(
          builder: (context) {
            return BlocConsumer<NostrServiceLoadingCubit, bool?>(
              listener: (context, state) {
                // ! state is nullable, so don't use state or !state directly.
                final weAreGood = state == true;

                if (weAreGood) {
                  Navigator.of(context).pushReplacementNamed(Paths.bottomBar);
                }
              },
              builder: (context, state) {
                // ! state is nullable, so don't use state or !state directly.
                final weAreGood = state == true;
                final somethingUnexpectedHappened = state == false;
                final loading = state == null;

                if (loading) {
                  return SizedBox(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        MunawarahLogo(width: 150),
                        const SizedBox(height: 40),
                        LinearProgressIndicator(),
                      ],
                    ),
                  );
                } else if (weAreGood) {
                  return const SizedBox.shrink();
                } else if (somethingUnexpectedHappened) {
                  return const Center(
                    child: Text('Something unexpected happened'),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            );
          },
        ),
      ),
    );
  }
}
