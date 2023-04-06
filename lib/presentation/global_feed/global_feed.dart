import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../buisness_logic/home_page_after_login/home_page_after_login_cubit.dart';
import '../../constants/strings.dart';
import '../../model/note.dart';
import '../../services/utils/routing.dart';
import '../general/widget/post_card.dart';
import 'widgets/custome_app_bar.dart';

class GlobalFeed extends StatelessWidget {
  const GlobalFeed({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: AppStrings.globalFeed),
      body: BlocProvider<HomePageAfterLoginCubit>.value(
        value: Routing.homePageAfterLoginCubit,
        child: Builder(
          builder: (context) {
            return BlocBuilder<HomePageAfterLoginCubit,
                HomePageAfterLoginState>(
              builder: (context, state) {
                return MarginedBody(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        ...state.feedPosts
                            .map(
                              (e) => NoteCard(
                                note: Note.fromEvent(e),
                              ),
                            )
                            .toList(),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
