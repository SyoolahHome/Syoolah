// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'app_cubit.dart';

class AppState extends Equatable {
  final List<RelayConfiguration> relaysConfigurations;
  final bool isReconnecting;
  final bool isValidUrl;
  @override
  List<Object> get props => [
        isReconnecting,
        relaysConfigurations,
        isValidUrl,
      ];

  const AppState({
    this.relaysConfigurations = const [],
    this.isReconnecting = false,
    this.isValidUrl = false,
  });

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
}

class AppInitial extends AppState {
  const AppInitial({
    required super.relaysConfigurations,
  });
}
