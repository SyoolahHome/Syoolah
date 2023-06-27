import 'dart:convert';

import 'package:dart_nostr/dart_nostr.dart';
import 'package:ditto/buisness_logic/users_list_to_follow_cubit/users_list_to_follow_cubit.dart';
import 'package:ditto/model/user_meta_data.dart';
import 'package:ditto/presentation/general/widget/note_card/wudgets/note_avatat_and_name.dart';
import 'package:ditto/services/database/local/local_database.dart';
import 'package:ditto/services/nostr/nostr_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersListToFollow extends StatelessWidget {
  const UsersListToFollow({
    super.key,
    required this.pubKeys,
    this.noBg = false,
  });

  final List<String> pubKeys;
  final bool noBg;
  @override
  Widget build(BuildContext context) {
    final emptyNostrStrea = NostrEventsStream(
      request: NostrRequest(filters: const []),
      stream: const Stream.empty(),
      subscriptionId: "",
    );

    final String appCurrentUserPublicKey =
        Nostr.instance.keysService.derivePublicKey(
      privateKey: LocalDatabase.instance.getPrivateKey()!,
    );

    return BlocProvider<UsersListToFollowCubit>(
      create: (context) => UsersListToFollowCubit(
        usersListMetadata: pubKeys.isEmpty
            ? emptyNostrStrea
            : NostrService.instance.subs.usersListMetadata(pubKeys),
        currentUserFollowing:
            NostrService.instance.subs.currentUserFollowings(),
        currentUserFollowers: NostrService.instance.subs.currentUserFollowers(),
      ),
      child: Builder(
        builder: (context) {
          return BlocBuilder<UsersListToFollowCubit, UsersListToFollowState>(
            builder: (context, state) {
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 10),

                // height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: noBg
                      ? Colors.transparent
                      : Theme.of(context)
                          .colorScheme
                          .background
                          .withOpacity(.1),
                ),
                child: ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: state.pubKeysMetadata.length,
                  itemBuilder: (context, index) {
                    final current = state.pubKeysMetadata[index];
                    final metadata = UserMetaData.fromJson(
                        jsonDecode(current.content) as Map<String, dynamic>);

                    return Animate(
                      delay: Duration(milliseconds: 200 + index * 200),
                      effects: const <Effect>[
                        FadeEffect(),
                        SlideEffect(begin: Offset(0, 0.5))
                      ],
                      child: Container(
                        margin: const EdgeInsets.all(15),
                        child: NoteAvatarAndName(
                          appCurrentUserPublicKey: appCurrentUserPublicKey,
                          userPubKey: current.pubkey,
                          showFollowButton: true,
                          avatarUrl: metadata.picture!,
                          nameToShow: metadata.nameToShow(),
                          memeberShipStartedAt: current.createdAt,
                        ),
                      ),
                    );
                  },
                ),
                // Column(
                //   children: List.generate(
                //     state.pubKeysMetadata.length,
                //     (index) {

                //     },
                //   ),
                // ),
              );
            },
          );
        },
      ),
    );
  }
}
