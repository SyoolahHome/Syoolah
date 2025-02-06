import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'user_bolt11_invoice_prompt_state.dart';

class UserBolt11InvoicePromptCubit extends Cubit<UserBolt11InvoicePromptState> {
  late final TextEditingController amountController;
  late final TextEditingController descriptionController;
  late final FocusNode amountFocusNode;

  final String? initialDescription;

  UserBolt11InvoicePromptCubit({
    required this.initialDescription,
  }) : super(UserBolt11InvoicePromptInitial()) {
    _init();
  }

  void _init() {
    amountFocusNode = FocusNode()..requestFocus();

    amountController = TextEditingController(text: "0")
      ..addListener(() {
        final amount = amountController.text.trim();

        if (amount.isEmpty) {
          amountController.text = "0";
        }

        if (amount.startsWith("0") && amount.length > 1) {
          amountController.text = amount.substring(1);
        }

        final maybeInt = int.tryParse(amount);

        if (maybeInt == null) {
          return;
        }

        emit(state.copyWith(amount: maybeInt));
      });

    descriptionController = TextEditingController(text: initialDescription)
      ..addListener(() {
        final description = descriptionController.text;

        emit(state.copyWith(description: description));
      });
  }

  Future<void> close() {
    amountFocusNode.dispose();

    amountController.dispose();
    descriptionController.dispose();

    return super.close();
  }
}
