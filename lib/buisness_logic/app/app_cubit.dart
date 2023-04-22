import 'package:bloc/bloc.dart';
import 'package:dart_nostr/nostr/model/relay_informations.dart';
import 'package:ditto/services/bottom_sheet/bottom_sheet.dart';
import 'package:ditto/services/nostr/nostr.dart';
import 'package:ditto/services/utils/alerts.dart';
import 'package:ditto/services/utils/extensions.dart';
import 'package:ditto/services/utils/utils.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../constants/configs.dart';
import '../../model/profile_option.dart';
import '../../model/relat_configuration.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  TextEditingController? relayUrlController;

  AppCubit()
      : super(AppInitial(
          relaysConfigurations: AppConfigs.relaysUrls
              .map((url) => RelayConfiguration(url: url))
              .toList(),
        )) {
    relayUrlController = TextEditingController()
      ..addListener(
        () {
          emit(
            state.copyWith(
              isValidUrl: relayUrlController!.text.isValidWebSocketSchema,
            ),
          );
        },
      );
  }

  List<String> get relaysUrls =>
      state.relaysConfigurations.map((e) => e.url).toList();

  Future<void> addRelay() async {
    try {
      Uri.parse(relayUrlController!.text);
      RelayConfiguration relay = RelayConfiguration(
        url: relayUrlController!.text,
      );

      emit(
        state.copyWith(
          relaysConfigurations: [...state.relaysConfigurations, relay],
        ),
      );
    } catch (e) {
      throw Exception('Invalid url');
    } finally {
      relayUrlController!.clear();
    }
  }

  void removeRelay(
    RelayConfiguration relay,
  ) {
    emit(
      state.copyWith(
        relaysConfigurations: state.relaysConfigurations
            .where((element) => element.url != relay.url)
            .toList(),
      ),
    );
  }

  void reconnectToRelays() {
    emit(state.copyWith(isReconnecting: true));
    final activeSelectedRelaysUrls = state.relaysConfigurations
        .where((relay) => relay.isActive)
        .map((relay) => relay.url)
        .toList();
    NostrService.instance
        .init(relaysUrls: activeSelectedRelaysUrls, isReconnecting: true);
    emit(state.copyWith(isReconnecting: false));
  }

  void changeRelayState({
    required int index,
    required bool isActive,
  }) {
    final newRelaysConfigurations = [...state.relaysConfigurations];
    newRelaysConfigurations[index] =
        newRelaysConfigurations[index].copyWith(isActive: isActive);

    emit(state.copyWith(relaysConfigurations: newRelaysConfigurations));
  }

  void showAddRelaySheet(BuildContext context) {
    BottomSheetService.showAddRelaySheet(
      context: context,
      onAdd: addRelay,
    );
  }

  @override
  Future<void> close() {
    relayUrlController!.dispose();
    return super.close();
  }

  void showRemoveRelayDialog({
    required BuildContext context,
    required RelayConfiguration relayConfig,
  }) {
    AlertsService.showRemoveRelayDialog(
      context,
      relayConfig: relayConfig,
      onRemove: () {
        removeRelay(relayConfig);
      },
    );
  }

  void showRelayOptionsSheet(
    BuildContext context, {
    required RelayConfiguration relay,
    RelayInformations? relayInformations,
  }) {
    BottomSheetService.showRelayOptionsSheet(
      context: context,
      relay: relay,
      relayInformations: relayInformations,
      options: <BottomSheetOption>[
        BottomSheetOption(
          title: "Name: ${relayInformations?.name}",
          icon: FlutterRemix.file_copy_2_line,
          onPressed: () {
            AppUtils.copy(
              relayInformations?.name ?? '',
            );
          },
        ),
        BottomSheetOption(
          title: "Description: ${relayInformations?.description}",
          icon: FlutterRemix.file_copy_2_line,
          onPressed: () {
            AppUtils.copy(
              relayInformations?.description ?? '',
            );
          },
        ),
        BottomSheetOption(
          title: "Author: ${relayInformations?.pubkey}",
          icon: FlutterRemix.file_copy_2_line,
          onPressed: () {
            AppUtils.copy(
              relayInformations?.pubkey ?? '',
            );
          },
        ),
        BottomSheetOption(
          title: "Contact: ${relayInformations?.contact}",
          icon: FlutterRemix.file_copy_2_line,
          onPressed: () {
            AppUtils.copy(
              relayInformations?.contact ?? '',
            );
          },
        ),
        BottomSheetOption(
          title: "Software: ${relayInformations?.software}",
          icon: FlutterRemix.file_copy_2_line,
          onPressed: () {
            AppUtils.copy(
              relayInformations?.software ?? '',
            );
          },
        ),
        BottomSheetOption(
          title: "Version: ${relayInformations?.version}",
          icon: FlutterRemix.file_copy_2_line,
          onPressed: () {
            AppUtils.copy(
              relayInformations?.version ?? '',
            );
          },
        ),
        BottomSheetOption(
          title: "Supported Nips: ${relayInformations?.supportedNips}",
          icon: FlutterRemix.file_copy_2_line,
          onPressed: () {
            AppUtils.copy(
              relayInformations?.supportedNips.toString() ?? '',
            );
          },
        ),
      ],
    );
  }
}
