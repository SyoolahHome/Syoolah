import 'package:dart_nostr/dart_nostr.dart';
import 'package:ditto/buisness_logic/app/app_cubit.dart';
import 'package:ditto/buisness_logic/events_loader_cubit/events_loader_cubit.dart';
import 'package:ditto/model/messages/chat_message.dart';
import 'package:ditto/presentation/dms/chat_screen_cubit/chat_screen_cubit.dart';
import 'package:ditto/services/database/local/local_database.dart';
import 'package:ditto/services/nostr/nip04.dart';
import 'package:ditto/services/nostr/nip_17_tmp.dart';
import 'package:ditto/services/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

class MessagesListView extends StatelessWidget {
  const MessagesListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final chatCubit = context.read<ChatScreenCubit>();
    final peerUser = chatCubit.chatConversation?.userToShow;

    final currentUser = NostrKeyPairs(
      private: LocalDatabase.instance.getPrivateKey()!,
    );

    if (peerUser == null) {
      return const Center(child: Text('No user to chat with'));
    }

    final initialMessages = chatCubit.chatConversation?.messages;

    return Theme(
      data: Theme.of(context).copyWith(
        inputDecorationTheme: const InputDecorationTheme(
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(16),
        ),
      ),
      child: BlocProvider<EventsLoaderCubit<ChatMessage>>(
        create: (context) => EventsLoaderCubit(
          instantResultsToAddInitially: initialMessages,
          currentUserKeyPair: currentUser,
          neverCloseInitialLoading: true,
          relays: context.read<AppCubit>().relaysUrls,
          eventModifier: (ev) async {
            if (ev.kind == 1059) {
              final event = await NIP17.nip44decrypt(
                ev,
                currentUser.private,
              );

              final p = event.tags!
                  .nostrTags('p')
                  .firstWhereOrNull((e) => e[1] != currentUser.public);

              if (p == null) {
                return null;
              }

              if (event.pubkey != currentUser.public && p[1] != peerUser) {
                return null;
              }

              if (p[1] != peerUser && p[1] != currentUser.public) {
                return null;
              }

              return ChatMessage.fromEvent(event, event.content!);
            }

            final p = ev.tags!
                .nostrTags('p')
                .firstWhereOrNull((e) => e[1] != currentUser.public);

            final peerPublicKey =
                ev.pubkey == currentUser.public ? p![1] : ev.pubkey;

            final nip04decrypted = Nip4.decryptContent(
              ev.content!,
              peerPublicKey,
              currentUser,
            );

            final event = ChatMessage.fromEvent(ev, nip04decrypted);

            return event;
          },
          eventsSorter: (messages) {
            messages.sort((a, b) {
              return b.originalNostrEvent!.createdAt!
                  .compareTo(a.originalNostrEvent!.createdAt!);
            });

            return messages.reversed.toList();
          },
          multiInitialFilters: [
            NostrFilter(
              kinds: const [4],
              authors: [
                currentUser.public,
                peerUser,
              ],
              p: [
                currentUser.public,
                peerUser,
              ],
            ),
            NostrFilter(
              kinds: const [1059],
              p: [
                currentUser.public,
              ],
            ),
          ],
        ),
        child: Builder(
          builder: (context) {
            return BlocBuilder<EventsLoaderCubit<ChatMessage>,
                EventsLoaderState<ChatMessage>>(
              builder: (context, state) {
                final messages = state.results;

                final currentUserData = types.User(
                  firstName: 'You',
                  role: types.Role.user,
                  createdAt: DateTime.now().microsecondsSinceEpoch,
                  id: currentUser.public,
                );

                final peerUser = types.User(
                  firstName: chatCubit.targetUser?.name ?? 'Unknown',
                  role: types.Role.user,
                  createdAt: chatCubit.targetUser?.userMetadataEvent?.createdAt!
                      .microsecondsSinceEpoch,
                  imageUrl: chatCubit.targetUser?.picture,
                  id: chatCubit.targetUser?.userMetadataEvent!.pubkey ?? 'peer',
                );

                return Chat(
                  theme: Theme.of(context).brightness == Brightness.dark
                      ? DarkChatTheme(
                          inputTextCursorColor:
                              Theme.of(context).colorScheme.onSecondary,
                          primaryColor:
                              Theme.of(context).colorScheme.onSecondary,
                          sentMessageBodyTextStyle:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                        fontWeight: FontWeight.w700,
                                      ) ??
                                  const TextStyle(),
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          inputBackgroundColor: Theme.of(context)
                                  .inputDecorationTheme
                                  .fillColor ??
                              Theme.of(context)
                                  .colorScheme
                                  .onSecondary
                                  .withOpacity(.2),
                        )
                      : DefaultChatTheme(),
                  showUserAvatars: true,
                  showUserNames: true,
                  user: currentUserData,
                  messages: messages
                      .map(
                        (e) => types.TextMessage(
                          createdAt: e.originalNostrEvent!.createdAt!
                              .millisecondsSinceEpoch,
                          type: types.MessageType.text,
                          id: e.originalNostrEvent!.id!,
                          text: e.originalMessage,
                          author:
                              e.originalNostrEvent!.pubkey == currentUser.public
                                  ? currentUserData
                                  : peerUser,
                        ),
                      )
                      .toList(),
                  onSendPressed: (text) {
                    chatCubit.sendMessage(
                      text.text,
                      onMessageSent: (event) {
                        context
                            .read<EventsLoaderCubit<ChatMessage>>()
                            .addItemManually(
                              ChatMessage.fromEvent(event, text.text),
                            );
                      },
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
