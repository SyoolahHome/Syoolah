part of 'attestation_info_cubit.dart';

sealed class AttestationInfoState extends Equatable {
  const AttestationInfoState();

  @override
  List<Object> get props => [];
}

final class AttestationInfoInitial extends AttestationInfoState {}
