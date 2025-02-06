import 'package:dart_nostr/nostr/core/key_pairs.dart';
import 'package:ditto/buisness_logic/cubit/dms_cubit.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:ditto/presentation/general/widget/title.dart';
import 'package:ditto/services/database/local/local_database.dart';
import 'package:ditto/services/utils/extensions.dart';
import 'package:ditto/services/utils/paths.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/abstractions/abstractions.dart';

class DMS extends BottomBarScreen {
  const DMS({super.key});

  @override
  Widget build(BuildContext context) {
    final nostrKeyPairs = NostrKeyPairs(
      private: LocalDatabase.instance.getPrivateKey()!,
    );

    return BlocProvider(
      create: (c) => DmsCubit(),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).padding.top,
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 20,
            ),
            child: MarginedBody(
              child: HeadTitle(
                title: "Direct Messages".tr(),
                isForSection: true,
              ),
            ),
          ),
          Flexible(
            child: Builder(
              builder: (context) {
                final cubit = context.read<DmsCubit>();

                return BlocBuilder<DmsCubit, DmsState>(
                  builder: (context, state) {
                    final results = [
                      ...cubit.groupByVisisbility(
                        state.chatConvoMessages.values.toList(),
                        nostrKeyPairs.public,
                      ),
                    ];

                    if (results.isEmpty) {
                      return const Center(
                        child: Text('No conversations yet'),
                      );
                    }

                    return ListView.builder(
                      itemCount: results.length,
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final curr = results[index];

                        final userData = state.userMetadatas[curr.userToShow];

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2.5),
                          child: ListTile(
                            contentPadding: MarginedBody.defaultMargin,
                            tileColor: Theme.of(context)
                                .colorScheme
                                .onSecondary
                                .withOpacity(.1),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                userData?.picture ?? userData?.banner ?? "",
                              ),
                            ),
                            trailing: Text(
                              curr.messages.isNotEmpty
                                  ? curr.messages.first.originalNostrEvent
                                          ?.createdAt
                                          ?.ago() ??
                                      ""
                                  : 'No messages yet',
                              style: Theme.of(context)
                                  .textTheme
                                  .labelMedium
                                  ?.copyWith(
                                      color: Theme.of(context)
                                          .textTheme
                                          .labelMedium
                                          ?.color
                                          ?.withOpacity(.8)),
                            ),
                            title: Text(
                              userData?.name ?? 'Unknown',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            subtitle: Text(
                              curr.messages.isNotEmpty
                                  ? curr.messages.first.originalMessage
                                  : 'No messages yet',
                            ),
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                Paths.dmsScreen,
                                arguments: {
                                  'chat_conversation': curr,
                                  'user_data': userData,
                                },
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
