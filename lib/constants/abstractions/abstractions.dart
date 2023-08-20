import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BottomBarScreen extends StatelessWidget {
  const BottomBarScreen({super.key});
}

abstract class NewPostAssetWidget extends StatelessWidget {
  const NewPostAssetWidget({super.key});
}

abstract class CurrentUserTabViewCubit<T> extends Cubit<T> {
  CurrentUserTabViewCubit(super.initialState);

  Duration get durationToWaitBeforeHidingLoadingIndicator =>
      Duration(seconds: 3);

  void init();
}

abstract class SignUpStepViewWidget extends Widget {}

abstract class UserProfileTab extends StatelessWidget {
  final String userPubKey;

  UserProfileTab({
    super.key,
    required this.userPubKey,
  });
}
