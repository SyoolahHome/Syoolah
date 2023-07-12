import 'package:bloc/bloc.dart';
import 'package:dart_nostr/nostr/model/relay_informations.dart';
import 'package:ditto/constants/app_configs.dart';
import 'package:ditto/model/bottom_sheet_option.dart';
import 'package:ditto/model/relay_configuration.dart';
import 'package:ditto/services/bottom_sheet/bottom_sheet_service.dart';
import 'package:ditto/services/nostr/nostr_service.dart';
import 'package:ditto/services/utils/alerts_service.dart';
import 'package:ditto/services/utils/app_utils.dart';
import 'package:ditto/services/utils/extensions.dart';
import 'package:ditto/services/utils/snackbars.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../constants/app_enums.dart';

part 'app_state.dart';

/// {@template app_cubit}
///  A general cubit for the app that is responsible for some global and general configuration and members that can be used on many places after the user is authenticated.
/// {@endtemplate}

class AppCubit extends Cubit<AppState> {
  /// The responsible controller about holding the input if a new relay url.
  TextEditingController? relayUrlController;

  /// A list of the relays urls that is used in Nostr operations.
  List<String> get relaysUrls => state.relaysConfigurations.toListOfUrls();

  /// {@macro app_cubit}
  AppCubit() : super(AppState.initial()) {
    _init();
  }

  @override
  Future<void> close() {
    relayUrlController?.dispose();

    return super.close();
  }

  /// Adds a new relay to the existent collection of relays at the given [position], using the text field associated with the [relayUrlController].
  /// if the [relayUrlController] is not initialized already, it will ignore.
  /// if [clearControllerAtEnd] is [false], then the [relayUrlController] will not be cleared after this method is called.
  /// if a manual [relay] is given, it will have priority.
  Future<void> addRelay({
    RelayConfiguration? relay,
    AppCubitNewRelayPosition addPosition = AppCubitNewRelayPosition.top,
    bool clearControllerAtEnd = true,
  }) async {
    TextEditingController? controller;

    try {
      if (relay != null) {
        _emitNewRelayBasedOnPosition(
          relay: relay,
          position: addPosition,
        );
      } else {
        controller = relayUrlController;
        if (controller == null) {
          return;
        }

        var newRelayFromUserInput = RelayConfiguration(url: controller.text);

        _emitNewRelayBasedOnPosition(
          relay: newRelayFromUserInput,
          position: addPosition,
        );
      }
    } finally {
      if (clearControllerAtEnd) controller?.clear();
    }

    reconnectToRelays();
  }

  /// Removes the given [relay] from the current state.
  void removeRelay(RelayConfiguration relay) {
    final newRelaysConfigurations = state.relaysConfigurations.without(relay);

    emit(state.copyWith(relaysConfigurations: newRelaysConfigurations));
  }

  /// Reconnects/connects to all relays found from the current state
  Future<void> reconnectToRelays() async {
    try {
      emit(state.copyWith(isReconnecting: true));

      await NostrService.instance.init(
        relaysUrls: state.relaysConfigurations.activeUrls(),
      );
    } catch (e) {
    } finally {
      emit(state.copyWith(isReconnecting: false));
    }
  }

  /// Selects the relay at the given [index] and sets it's [isActive] value.
  void selectRelay({
    required int index,
    required bool isActive,
  }) {
    final newRelaysConfigurations = List.of(state.relaysConfigurations);

    newRelaysConfigurations[index] =
        newRelaysConfigurations[index].copyWith(isActive: isActive);

    emit(state.copyWith(relaysConfigurations: newRelaysConfigurations));
  }

  /// A wrapper for showing the responsible bottom sheet about adding a new relay.
  void showAddRelaySheet(
    BuildContext context, {
    required Future<void> Function() onAdd,
  }) {
    BottomSheetService.showAddRelaySheet(context: context, onAdd: onAdd);
  }

  /// Shows an alert requesting to remove the given [relay] from the current state.
  Future showRemoveRelayDialog(
    BuildContext context, {
    required RelayConfiguration relay,
  }) {
    return AlertsService.showRemoveRelayDialog(
      context,
      relay: relay,
      onRemoveTap: removeRelay,
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
      // TODO: move this to a separated class, file.
      options: <BottomSheetOption>[
        BottomSheetOption(
          title: "Name: ${relayInformations?.name}",
          icon: FlutterRemix.file_copy_2_line,
          onPressed: () {
            AppUtils.instance.copy(
              relayInformations?.name ?? '',
            );
          },
        ),
        BottomSheetOption(
          title: "Description: ${relayInformations?.description}",
          icon: FlutterRemix.file_copy_2_line,
          onPressed: () {
            AppUtils.instance.copy(
              relayInformations?.description ?? '',
            );
          },
        ),
        BottomSheetOption(
          title: "Author: ${relayInformations?.pubkey}",
          icon: FlutterRemix.file_copy_2_line,
          onPressed: () {
            AppUtils.instance.copy(
              relayInformations?.pubkey ?? '',
            );
          },
        ),
        BottomSheetOption(
          title: "Contact: ${relayInformations?.contact}",
          icon: FlutterRemix.file_copy_2_line,
          onPressed: () {
            AppUtils.instance.copy(
              relayInformations?.contact ?? '',
            );
          },
        ),
        BottomSheetOption(
          title: "Software: ${relayInformations?.software}",
          icon: FlutterRemix.file_copy_2_line,
          onPressed: () {
            AppUtils.instance.copy(
              relayInformations?.software ?? '',
            );
          },
        ),
        BottomSheetOption(
          title: "Version: ${relayInformations?.version}",
          icon: FlutterRemix.file_copy_2_line,
          onPressed: () {
            AppUtils.instance.copy(
              relayInformations?.version ?? '',
            );
          },
        ),
        BottomSheetOption(
          title: "Supported Nips: ${relayInformations?.supportedNips}",
          icon: FlutterRemix.file_copy_2_line,
          onPressed: () {
            AppUtils.instance.copy(
              relayInformations?.supportedNips.toString() ?? '',
            );
          },
        ),
      ],
    );
  }

  /// A wrapper to show the translations sheet
  /// The current context is got via [context.locale].
  void showTranslationsSheet(BuildContext context) {
    BottomSheetService.showOnBoardingTranslationsSheet(
      context,
      options: AppConfigs.localeItems.toBottomSheetTranslationOptions(
        context,
        onEachTap: (localeItem) async {
          await AppUtils.instance.changeLocale(context, localeItem.locale);
          Navigator.of(context).pop();
          SnackBars.text(
            context,
            "laungageApplied".tr(
              args: [localeItem.locale.languageCode],
            ),
          );
        },
      ),
    );
  }

  void _init() {
    relayUrlController = TextEditingController()
      ..addListener(
        () {
          final controller = relayUrlController;

          if (controller != null) {
            final isValidWebSocketSchema =
                controller.text.isValidWebSocketSchema;

            emit(state.copyWith(isValidUrl: isValidWebSocketSchema));
          }
        },
      );
  }

  /// inserts the given [relay] based on its [position] to the current state
  void _emitNewRelayBasedOnPosition({
    required AppCubitNewRelayPosition position,
    required RelayConfiguration relay,
  }) {
    var currentStateList = List.of(state.relaysConfigurations);

    switch (position) {
      case AppCubitNewRelayPosition.top:
        currentStateList.insert(0, relay);
        break;
      case AppCubitNewRelayPosition.bottom:
        currentStateList.add(relay);
        break;
    }

    emit(state.copyWith(relaysConfigurations: currentStateList));
  }
}
