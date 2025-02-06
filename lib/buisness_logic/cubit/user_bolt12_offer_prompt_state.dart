part of 'user_bolt12_offer_prompt_cubit.dart';

class UserBolt12OfferPromptState extends Equatable {
  const UserBolt12OfferPromptState({
    this.bolt12Input,
  });

  final String? bolt12Input;

  @override
  List<Object?> get props => [
        bolt12Input,
      ];

  UserBolt12OfferPromptState copyWith({
    String? bolt12Input,
  }) {
    return UserBolt12OfferPromptState(
      bolt12Input: bolt12Input ?? this.bolt12Input,
    );
  }
}

final class UserBolt12OfferPromptInitial extends UserBolt12OfferPromptState {}
