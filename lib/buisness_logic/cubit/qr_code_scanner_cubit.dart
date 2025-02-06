import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:async';
import 'package:mobile_scanner/mobile_scanner.dart';

part 'qr_code_scanner_state.dart';

class QrCodeScannerCubit extends Cubit<QrCodeScannerState> {
  QrCodeScannerCubit() : super(QrCodeScannerInitial()) {
    _init();
  }

  MobileScannerController? controller;

  void _init() {
    controller = MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates,
      detectionTimeoutMs: 750,
    );

    controller?.start();
  }

  Future<void> close() async {
    controller?.dispose();

    return super.close();
  }
}
