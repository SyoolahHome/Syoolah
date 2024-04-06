import 'package:dart_nostr/nostr/core/key_pairs.dart';
import 'package:ditto/buisness_logic/cubit/dms_cubit.dart';
import 'package:ditto/services/database/local/local_database.dart';
import 'package:ditto/services/utils/paths.dart';
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
      child: Builder(
        builder: (context) {
          final cubit = context.read<DmsCubit>();

          return BlocBuilder<DmsCubit, DmsState>(
            builder: (context, state) {
              final results = cubit.groupByVisisbility(
                state.chatConvoMessages.values.toList(),
                nostrKeyPairs.public,
              );

              if (results.isEmpty) {
                return const Center(
                  child: Text('No conversations yet'),
                );
              }

              return ListView.builder(
                itemCount: results.length,
                itemBuilder: (context, index) {
                  final curr = results[index];

                  final userData = state.userMetadatas[curr.userToShow];

                  return ListTile(
                    tileColor: Colors.red,
                    title: Text(userData?.name ?? 'Unknown'),
                    subtitle: Text(curr.messages.isNotEmpty
                        ? curr.messages.first.originalMessage
                        : 'No messages yet'),
                    onTap: () {
                      Navigator.of(context).pushNamed(
                        Paths.dmsScreen,
                        arguments: {
                          'chat_conversation': curr,
                          'user_data': userData,
                        },
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
