import 'package:bloc/bloc.dart';
import 'package:dart_nostr/nostr/model/relay_informations.dart';
import 'package:ditto/constants/app_strings.dart';
import 'package:ditto/services/bottom_sheet/bottom_sheet_service.dart';
import 'package:ditto/services/nostr/nostr_service.dart';
import 'package:ditto/services/utils/alerts_service.dart';
import 'package:ditto/services/utils/extensions.dart';
import 'package:ditto/services/utils/app_utils.dart';
import 'package:ditto/services/utils/snackbars.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_remix/flutter_remix.dart';

import '../../constants/app_configs.dart';
import '../../model/bottom_sheet_option.dart';
import '../../model/relay_configuration.dart';
import '../../presentation/general/widget/button.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  TextEditingController? relayUrlController;

  List<String> get relaysUrls =>
      state.relaysConfigurations.map((e) => e.url).toList();

  AppCubit()
      : super(AppInitial(
          relaysConfigurations: AppConfigs.relaysUrls
              .map((url) => RelayConfiguration(url: url))
              .toList(),
        )) {
    relayUrlController = TextEditingController()
      ..addListener(
        () {
          final controller = relayUrlController;

          if (controller == null) {
            return;
          }

          emit(
            state.copyWith(isValidUrl: controller.text.isValidWebSocketSchema),
          );
        },
      );
  }

  Future<void> addRelay() async {
    final controller = relayUrlController;
    if (controller == null) {
      return;
    }
    try {
      RelayConfiguration relay = RelayConfiguration(url: controller.text);
      emit(
        state.copyWith(
          relaysConfigurations: [...state.relaysConfigurations, relay],
        ),
      );
    } catch (e) {
    } finally {
      controller.clear();
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
    NostrService.instance.init(relaysUrls: activeSelectedRelaysUrls);
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
    relayUrlController?.dispose();

    return super.close();
  }

  void showRemoveRelayDialog({
    required BuildContext context,
    required RelayConfiguration relayConfig,
  }) {
    return AlertsService.showRemoveRelayDialog(
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

  void showTranslationsSheet(BuildContext context) {
    MunawarahButton applyButton(String text, Locale locale) {
      return MunawarahButton(
        onTap: () {
          AppUtils.changeLocale(context, locale);
          Navigator.of(context).pop();
          SnackBars.text(
              context, AppStrings.laungageApplied(locale.languageCode));
        },
        text: text,
        isSmall: true,
      );
    }

    BottomSheetService.showOnBoardingTranslationsSheet(
      context,
      options: [
        BottomSheetOption(
          title: 'English',
          icon: FlutterRemix.arrow_right_line,
          trailing: applyButton('Apply', Locale('en')),
        ),
        BottomSheetOption(
          title: 'Français',
          icon: FlutterRemix.arrow_right_line,
          trailing: applyButton('Appliquer', Locale('fr')),
        ),
        BottomSheetOption(
          title: 'German',
          icon: FlutterRemix.arrow_right_line,
          trailing: applyButton('Anwenden', Locale('de')),
        ),
        BottomSheetOption(
          title: 'Italian',
          icon: FlutterRemix.arrow_right_line,
          trailing: applyButton('Applicare', Locale('it')),
        ),
        BottomSheetOption(
          title: 'Spanish',
          icon: FlutterRemix.arrow_right_line,
          trailing: applyButton('Aplicar', Locale('es')),
        ),
        BottomSheetOption(
          title: 'Portuguese',
          icon: FlutterRemix.arrow_right_line,
          trailing: applyButton('Aplicar', Locale('pt')),
        ),
        BottomSheetOption(
          title: 'Russian',
          icon: FlutterRemix.arrow_right_line,
          trailing: applyButton('Применить', Locale('ru')),
        ),
        BottomSheetOption(
          title: 'Chinese',
          icon: FlutterRemix.arrow_right_line,
          trailing: applyButton('应用', Locale('zh')),
        ),
      ],
    );
  }
}
