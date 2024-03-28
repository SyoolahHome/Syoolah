import 'package:ditto/presentation/chat/widgets/text_field.dart';
import 'package:ditto/presentation/general/widget/bottom_sheet_title_with_button.dart';
import 'package:ditto/presentation/general/widget/button.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../buisness_logic/lnd_username/lnd_username_cubit.dart';
import '../../../../services/utils/app_utils.dart';

class UserLndUsernamePromptWidget extends StatelessWidget {
  const UserLndUsernamePromptWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final height = 10.0;

    return BlocProvider<LndUsernameCubit>(
      create: (context) => LndUsernameCubit(),
      child: Builder(
        builder: (context) {
          final cubit = context.read<LndUsernameCubit>();

          return BlocListener<LndUsernameCubit, LndUsernameState>(
            listener: (context, state) {
              if (state.isValid) {
                Navigator.of(context).pop(cubit.usernameController.text);
              } else if (state.error != null) {
                AppUtils.instance.displaySnackBar(context, state.error!);
              }
            },
            child: Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(height: height),
                  BottomSheetTitleWithIconButton(title: "Lnd Username"),
                  SizedBox(height: height),
                  CustomTextField(
                    controller: cubit.usernameController,
                    onSubmit: () => cubit.onUsernameSubmitted(),
                  ),
                  SizedBox(height: height),
                  BlocSelector<LndUsernameCubit, LndUsernameState, bool>(
                    selector: (state) => state.isValid,
                    builder: (context, isValid) {
                      return RoundaboutButton(
                        text: "Submit",
                        onTap: () => cubit.onUsernameSubmitted(),
                      );
                    },
                  ),
                  SizedBox(height: height),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
