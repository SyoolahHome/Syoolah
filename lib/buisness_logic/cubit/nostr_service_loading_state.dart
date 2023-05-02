part of 'nostr_service_loading_cubit.dart';

abstract class NostrServiceLoadingState extends Equatable {
  const NostrServiceLoadingState();

  @override
  List<Object> get props => [];
}

class NostrServiceLoadingInitial extends NostrServiceLoadingState {}
