import 'package:ditto/buisness_logic/cubit/qr_code_scanner_cubit.dart';
import 'package:ditto/presentation/general/widget/button.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class QrCodeScanner extends StatelessWidget {
  const QrCodeScanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final _navigator = Navigator.of(context);

    bool _isDataReturned = false;

    return BlocProvider<QrCodeScannerCubit>(
      create: (context) => QrCodeScannerCubit(),
      child: Builder(
        builder: (context) {
          final cubit = context.read<QrCodeScannerCubit>();

          return Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              MobileScanner(
                overlayBuilder: (context, constraints) {
                  return Center(
                    child: Container(
                      width: constraints.maxWidth * 0.8,
                      height: constraints.maxWidth * 0.8,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),
                    ),
                  );
                },
                controller: cubit.controller,
                fit: BoxFit.cover,
                onDetect: (capture) {
                  if (_isDataReturned) {
                    return;
                  }

                  _navigator.pop(capture.barcodes.firstOrNull?.rawValue);
                  _isDataReturned = true;
                },
                errorBuilder: (p0, p1, p2) {
                  debugPrint(
                    'An error occurred while scanning the QR code.., $p0, $p1, $p2',
                  );

                  return Center(
                    child: Text(
                      'An error occurred while scanning the QR code..',
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20) +
                    MarginedBody.defaultMargin,
                child: SizedBox(
                  width: double.infinity,
                  child: RoundaboutButton(
                    text: 'Cancel',
                    onTap: () async {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
