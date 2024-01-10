import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'attestation_info_state.dart';

class AttestationInfoCubit extends Cubit<AttestationInfoState> {
  final String pmtHash;
  final int amount;
  final int swapFee;

  AttestationInfoCubit({
    required this.pmtHash,
    required this.amount,
    required this.swapFee,
  }) : super(AttestationInfoInitial()) {
    _lookUp();
  }

  Future _lookUp() async {
    final ptag = await _getPtag();
  }

  String _getPtag() {
    // final publickKey = s.EC.secp256k1.createPublicKey(
    //   pmtHash,
    //   true,
    // );

    return "";
  }
}
