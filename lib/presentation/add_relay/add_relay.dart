import 'package:ditto/buisness_logic/app/app_cubit.dart';
import 'package:ditto/presentation/add_relay/widgets/add_button.dart';
import 'package:ditto/presentation/add_relay/widgets/field.dart';
import 'package:ditto/presentation/general/widget/bottom_sheet_title_with_button.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:ditto/services/utils/routing.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../general/pattern_widget.dart';

class AddRelayWidget extends StatelessWidget {
  const AddRelayWidget({
    super.key,
    required this.onAdd,
  });

  final Future<void> Function() onAdd;

  @override
  Widget build(BuildContext context) {
    const height = 10.0;

    return PatternScaffold(
      body: MarginedBody(
        child: BlocProvider<AppCubit>.value(
          value: Routing.appCubit,
          child: Builder(
            builder: (context) {
              return BlocBuilder<AppCubit, AppState>(
                builder: (context, state) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const SizedBox(height: height * 2),
                      BottomSheetTitleWithIconButton(
                        title: "addRelay".tr(),
                      ),
                      const SizedBox(height: height * 2),
                      const RelayUrlField(),
                      const SizedBox(height: height * 2),
                      AddButton(
                        onAdd: onAdd,
                        shouldAllowAdd: state.isValidUrl,
                      ),
                      const SizedBox(height: height * 2),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
