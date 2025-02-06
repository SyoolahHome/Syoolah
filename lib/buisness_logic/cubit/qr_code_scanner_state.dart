part of 'qr_code_scanner_cubit.dart';

sealed class QrCodeScannerState extends Equatable {
  const QrCodeScannerState();

  @override
  List<Object> get props => [];
}

final class QrCodeScannerInitial extends QrCodeScannerState {}
