import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../buisness_logic/attestaion_info/attestation_info_cubit.dart';

class AttestationInfo extends StatelessWidget {
  const AttestationInfo({
    super.key,
    required this.pmtHash,
    required this.amount,
    required this.swapFee,
  });

  final String pmtHash;
  final int amount;
  final int swapFee;
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AttestationInfoCubit>(
      create: (context) => AttestationInfoCubit(
        pmtHash: pmtHash,
        amount: amount,
        swapFee: swapFee,
      ),
      child: Builder(
        builder: (context) {
          final cubit = context.read<AttestationInfoCubit>();

          return BlocBuilder<AttestationInfoCubit, AttestationInfoState>(
            builder: (context, AttestationInfoState state) {
              return Container();
            },
          );
        },
      ),
    );
  }
}
