part of 'lnd_cubit.dart';

class LndState extends Equatable {
  final domain = "sakhir.me";

  final bool isLoading;
  final String username;
  final String lndAdress;
  final String lnurl;

  const LndState({
    required this.isLoading,
    required this.username,
    this.lndAdress = "",
    this.lnurl = "",
  });

  @override
  List<Object> get props => [
        isLoading,
        username,
      ];

  LndState copyWith({
    bool? isLoading,
    String? username,
    String? lndAdress,
    String? lnurl,
  }) {
    return LndState(
      isLoading: isLoading ?? this.isLoading,
      username: username ?? this.username,
      lndAdress: username! + "@" + domain,
      lnurl:
          "LNURL1DP68GURN8GHJ7MREFOUZFKRPIOGE8G9OZIGFZIULFZEBFIKZEGHZEZE56F4ZRGZUGZ",
    );
  }
}

class LndInitial extends LndState {
  LndInitial({
    super.isLoading = false,
    super.username = "",
  });
}
