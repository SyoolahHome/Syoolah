import 'package:ditto/presentation/onboarding/widgets/animated_logo.dart';
import 'package:ditto/services/utils/paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../buisness_logic/nostr_service_loading/nostr_service_loading_cubit.dart';

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
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    Paths.bottomBar,
                    (_) => false,
                  );
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
                      children: const <Widget>[
                        AppBrandLogo(width: 150),
                        SizedBox(height: 40),
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
