import 'package:dart_nostr/nostr/core/key_pairs.dart';
import 'package:ditto/buisness_logic/app/app_cubit.dart';
import 'package:ditto/model/messages/chat_conversation.dart';
import 'package:ditto/model/user_meta_data.dart';
import 'package:ditto/presentation/dms/chat_screen_cubit/chat_screen_cubit.dart';
import 'package:ditto/presentation/dms/messages_list_view.dart';
import 'package:ditto/services/database/local/local_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DmsScreen extends StatelessWidget {
  const DmsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    var chatConversation = args?['chat_conversation'] as ChatConversation?;

    final targetUser = args?['user_data'] as UserMetaData?;

    if (chatConversation == null && targetUser != null) {
      chatConversation = ChatConversation(
        userToShow: targetUser.userMetadataEvent!.pubkey,
        messages: const [],
        originalNostrEvent: null,
        originalMessage: '',
      );
    }

    final currentUserKeys = NostrKeyPairs(
      private: LocalDatabase.instance.getPrivateKey()!,
    );

    return BlocProvider(
      create: (context) => ChatScreenCubit(
        chatConversation: chatConversation,
        relays: context.read<AppCubit>().relaysUrls,
        currentUserKeys: currentUserKeys,
        targetUser: targetUser,
      ),
      child: Scaffold(
        appBar: AppBar(
          leadingWidth: 10,
          title: Row(
            children: [
              SizedBox(width: 10),
              ClipOval(
                child: Image.network(
                  targetUser?.picture ??
                      UserMetaData.placeholder(name: 'aa').picture!,
                  height: 40,
                  width: 40,
                ),
              ),
              SizedBox(width: 10),
              Text(targetUser?.name ?? 'DMS'),
            ],
          ),
        ),
        body: MessagesListView(),
      ),
    );
  }
}
