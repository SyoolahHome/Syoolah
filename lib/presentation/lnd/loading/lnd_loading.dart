import 'package:ditto/buisness_logic/lnd/lnd_cubit.dart';
import 'package:ditto/presentation/general/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../services/bottom_sheet/bottom_sheet_service.dart';

class LndLoading extends StatelessWidget {
  LndLoading({
    super.key,
  });

  LndCubit? cubit;
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    cubit = args['cubit'] as LndCubit;

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
            await cubit!.loadUser(
              onRelaysSigIsUnverifiedAndShouldNotBeUsed: () => print(
                  "Please try again with a valid relay, the trial event failed"),
              onRelaysSigIsVerifiedAndShouldBeUsed: () =>
                  print("Relays sig is verified and should be used"),
            );
          } else if (state.shouldCreateUser) {
            await cubit!.createUser(
              onGetUsername: () async {
                return "anas 92081";

                return BottomSheetService.promptUserForNewLndUsername(
                  context: context,
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
              onUserCreatedSuccesfully: () => {
                print("User created successfully"),
              },
            );
          }
        },
        child: Builder(
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
    );
  }
}
