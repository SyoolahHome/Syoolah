part of 'app_cubit.dart';

/// {@template app_state}
/// The state of [AppCubit]
/// {@endtemplate}
class AppState extends Equatable {
  /// the relays configs in use.
  final List<RelayConfiguration> relaysConfigurations;

  /// Weither the relays are reconnecting.
  final bool isReconnecting;

  /// Weither the new input relay relay is valid for add to the [relaysConfigurations]
  final bool isValidUrl;

  @override
  List<Object> get props => [
        isReconnecting,
        relaysConfigurations,
        isValidUrl,
      ];

  /// {@macro app_state}
  const AppState({
    this.relaysConfigurations = const [],
    this.isReconnecting = false,
    this.isValidUrl = false,
  });

  /// {@macro app_state}
  AppState copyWith({
    bool? isReconnecting,
    List<RelayConfiguration>? relaysConfigurations,
    bool? isValidUrl,
  }) {
    return AppState(
      relaysConfigurations: relaysConfigurations ?? this.relaysConfigurations,
      isReconnecting: isReconnecting ?? this.isReconnecting,
      isValidUrl: isValidUrl ?? this.isValidUrl,
    );
  }

  /// {@macro app_state}
  factory AppState.initial([List<RelayConfiguration>? relaysConfigurations]) {
    return AppInitial(
      relaysConfigurations:
          relaysConfigurations ?? AppConfigs.relaysConfigurations,
    );
  }
}

/// {@macro app_state}
class AppInitial extends AppState {
  const AppInitial({
    required super.relaysConfigurations,
  });
}
