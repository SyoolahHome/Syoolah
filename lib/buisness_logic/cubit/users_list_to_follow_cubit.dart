import 'package:bloc/bloc.dart';
import 'package:dart_nostr/dart_nostr.dart';
import 'package:ditto/services/nostr/nostr.dart';
import 'package:equatable/equatable.dart';

part 'users_list_to_follow_state.dart';

class UsersListToFollowCubit extends Cubit<UsersListToFollowState> {
  UsersListToFollowCubit(
    List<String> pubKeys,
  ) : super(UsersListToFollowInitial()) {
    NostrService.instance
        .usersListMetadata(
      pubKeys,
    )
        .listen(
      (event) {
        emit(
          state.copyWith(
            pubKeysMetadata: [
              ...state.pubKeysMetadata,
              event,
            ],
          ),
        );
      },
    );
  }
}
