import 'package:ditto/presentation/general/loading_widget.dart';
import 'package:ditto/presentation/general/widget/bottom_sheet_title_with_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../buisness_logic/cubit/eleven_labs_voices_selection_cubit.dart';
import '../general/widget/margined_body.dart';

class ElevenLabsVoicesSelection extends StatelessWidget {
  const ElevenLabsVoicesSelection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ElevenLabsVoicesSelectionCubit(),
      child: Builder(builder: (context) {
        return Column(
          // mainAxisSize: MainAxisSize.min,
          children: [
            MarginedBody(
              child: BottomSheetTitleWithIconButton(
                title: "available_voices".tr(),
              ),
            ),
            SizedBox(height: 10),
            BlocBuilder<ElevenLabsVoicesSelectionCubit,
                ElevenLabsVoicesSelectionState>(
              builder: (context, state) {
                if (state.voices != null) {
                  return Flexible(
                    child: SingleChildScrollView(
                      child: Column(
                        children: state.voices!
                            .map(
                              (voice) => ListTile(
                                onTap: () {
                                  Navigator.pop(context, voice.voiceId);
                                },
                                contentPadding: MarginedBody.defaultMargin +
                                    const EdgeInsets.symmetric(vertical: 5),
                                title: Text(
                                  voice.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelLarge
                                      ?.copyWith(),
                                ),
                                trailing: Icon(
                                  FlutterRemix.arrow_right_s_line,
                                  size: 30,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  );
                } else if (state.isLoading) {
                  return Container(
                    margin: EdgeInsets.only(top: 20),
                    child: LoadingWidget(),
                  );
                } else {
                  return Center(
                    child: Text("error".tr()),
                  );
                }
              },
            )
          ],
        );
      }),
    );
  }
}
