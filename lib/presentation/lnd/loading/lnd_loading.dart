import 'package:ditto/buisness_logic/lnd/lnd_cubit.dart';
import 'package:ditto/presentation/general/loading_widget.dart';
import 'package:ditto/services/utils/paths.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../services/bottom_sheet/bottom_sheet_service.dart';

class LndLoading extends StatelessWidget {
  LndLoading({
    super.key,
  });

  LndCubit? cubit;
  String? username;
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    cubit = args['cubit'] as LndCubit;
    username = args['username'] as String?;

    if (cubit == null) throw Exception("cubit is null");

    cubit!.startLndLoading();

    bool userActionChosen = false;

    return BlocProvider.value(
      value: cubit!,
      child: BlocListener<LndCubit, LndState>(
        listener: (context, state) async {
          if (userActionChosen) return;

          userActionChosen = true;
          if (state.shouldLoadUser) {
            assert(state.userData != null);

            await cubit!.loadUser(
              userData: state.userData!,
              onRelaysSigIsUnverifiedAndShouldNotBeUsed: () => print(
                  "Please try again with a valid relay, the trial event failed"),
              onRelaysSigIsVerifiedAndShouldBeUsed: () =>
                  print("Relays sig is verified and should be used"),
              onAllValidatedAndSuccess: (pending, preimages, v2, userData) {
                _navigateToUserDashboard(
                  context: context,
                  pending: pending,
                  preimages: preimages,
                  v2: v2,
                  userData: userData,
                );
              },
            );
          } else if (state.shouldCreateUser) {
            await cubit!.createUser(
              username: username,
              onUserCreatedSuccesfully: (userData) async {
                await cubit!.loadUser(
                  userData: userData,
                  onRelaysSigIsUnverifiedAndShouldNotBeUsed: () => print(
                      "Please try again with a valid relay, the trial event failed"),
                  onRelaysSigIsVerifiedAndShouldBeUsed: () =>
                      print("Relays sig is verified and should be used"),
                  onAllValidatedAndSuccess: (pending, preimages, v2, userData) {
                    _navigateToUserDashboard(
                      context: context,
                      pending: pending,
                      preimages: preimages,
                      v2: v2,
                      userData: userData,
                    );
                  },
                );
              },
              onChosenUsernameEmpty: () => {
                print("Please try again with a valid username"),
              },
              onChosenUsernameNotGood: (username) => {
                print(
                  "Please try again with a valid username, $username is not good.",
                ),
              },
              onStartCreatingUserAndLoading: () => {
                print("Creating user..."),
              },
              onTrialEventToRelayFailed: () => {
                print(
                    "Please try again with a valid relay, the trial event failed"),
              },
            );
          }
        },
        child: Scaffold(
          body: Builder(
            builder: (context) {
              final cubit = context.read<LndCubit>();

              return BlocSelector<LndCubit, LndState, bool>(
                selector: (state) => state.isLoading,
                builder: (context, isLoading) {
                  if (isLoading) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        BlocSelector<LndCubit, LndState, List<String>?>(
                          selector: (state) => state.loadingMessages,
                          builder: (context, loadingMessage) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children:
                                  loadingMessage!.map((e) => Text(e)).toList(),
                            );
                          },
                        ),
                        LoadingWidget(),
                      ],
                    );
                  } else {
                    return Text("laoading ends");
                  }
                },
              );
            },
          ),
        ),
      ),
    );
  }

  void _navigateToUserDashboard({
    required BuildContext context,
    required List pending,
    required String preimages,
    required bool v2,
    required Map<String, dynamic> userData,
  }) {
    Navigator.of(context).pushReplacementNamed(
      Paths.zaplockerDashboard,
      arguments: {
        'pending': pending,
        'preimages': preimages,
        'v2': v2,
        'userData': userData,
      },
    );
  }
}
