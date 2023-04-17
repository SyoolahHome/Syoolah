// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'app_cubit.dart';

class AppState extends Equatable {
  final List<RelayConfiguration> relaysConfigurations;
  final bool isReconnecting;
  final bool isValidUrl;
  const AppState({
    this.relaysConfigurations = const [],
    this.isReconnecting = false,
    this.isValidUrl = false,
  });

  @override
  List<Object> get props => [
        isReconnecting,
        relaysConfigurations,
        isValidUrl,
      ];

  AppState copyWith({
    bool? isReconnecting,
    List<RelayConfiguration>? relaysConfigurations,
    bool? isValidUrl,
  }) {
    return AppState(
      isValidUrl: isValidUrl ?? this.isValidUrl,
      isReconnecting: isReconnecting ?? this.isReconnecting,
      relaysConfigurations: relaysConfigurations ?? this.relaysConfigurations,
    );
  }
}

class AppInitial extends AppState {
  const AppInitial({
    required super.relaysConfigurations,
  });
}
