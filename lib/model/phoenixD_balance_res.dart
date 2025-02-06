import 'package:equatable/equatable.dart';

class PhoenixDBalanceResponse extends Equatable {
  final int? balanceSat;
  final int? feeCreditSat;

  PhoenixDBalanceResponse({
    this.balanceSat,
    this.feeCreditSat,
  });

  factory PhoenixDBalanceResponse.fromMap(Map<String, dynamic> data) {
    return PhoenixDBalanceResponse(
      balanceSat: data['balanceSat'],
      feeCreditSat: data['feeCreditSat'],
    );
  }

  @override
  List<Object?> get props => [
        balanceSat,
        feeCreditSat,
      ];
}
