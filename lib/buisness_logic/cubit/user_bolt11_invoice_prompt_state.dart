part of 'user_bolt11_invoice_prompt_cubit.dart';

class UserBolt11InvoicePromptState extends Equatable {
  const UserBolt11InvoicePromptState({
    this.amount = 0,
    this.description,
  });

  final int amount;
  final String? description;

  @override
  List<Object?> get props => [
        amount,
        description,
      ];

  UserBolt11InvoicePromptState copyWith({
    String? description,
    int? amount,
  }) {
    return UserBolt11InvoicePromptState(
      amount: amount ?? this.amount,
      description: description ?? this.description,
    );
  }
}

final class UserBolt11InvoicePromptInitial
    extends UserBolt11InvoicePromptState {}
