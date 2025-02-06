import 'package:ditto/buisness_logic/cubit/user_bolt11_invoice_prompt_cubit.dart';
import 'package:ditto/constants/app_colors.dart';
import 'package:ditto/presentation/general/text_field.dart';
import 'package:ditto/presentation/general/widget/bottom_sheet_title_with_button.dart';
import 'package:ditto/presentation/general/widget/button.dart';
import 'package:ditto/presentation/general/widget/margined_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBolt11InvoicePrompt extends StatelessWidget {
  const UserBolt11InvoicePrompt({
    super.key,
    required this.enableMessageField,
    required this.initialDescription,
  });

  final String initialDescription;
  final bool enableMessageField;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final heightSpace = 10.0;

    return Padding(
      padding: EdgeInsets.only(
        bottom: mq.viewInsets.bottom,
      ),
      child: BlocProvider<UserBolt11InvoicePromptCubit>(
        create: (context) => UserBolt11InvoicePromptCubit(
          initialDescription: initialDescription,
        ),
        child: Builder(
          builder: (context) {
            final cubit = context.read<UserBolt11InvoicePromptCubit>();

            return MarginedBody(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(height: heightSpace * 2),
                  BottomSheetTitleWithIconButton(title: ""),
                  SizedBox(height: heightSpace * 2),
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          "Amount in SATs",
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontSize: Theme.of(context)
                                            .textTheme
                                            .titleLarge!
                                            .fontSize! +
                                        4,
                                  ),
                        ),
                        SizedBox(height: heightSpace),
                        EditableText(
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          controller: cubit.amountController,
                          focusNode: cubit.amountFocusNode,
                          style: Theme.of(context).textTheme.displayLarge ??
                              TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                          cursorColor:
                              Theme.of(context).textTheme.displayLarge?.color ??
                                  AppColors.grey,
                          selectionColor: (Theme.of(context)
                                      .textTheme
                                      .displayLarge
                                      ?.color ??
                                  AppColors.grey)
                              .withOpacity(.2),
                          backgroundCursorColor:
                              Theme.of(context).textTheme.displayLarge?.color ??
                                  AppColors.grey,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: heightSpace * 6),
                  if (enableMessageField) ...[
                    CustomTextField(
                      label: 'Additional Message (Optional)',
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 20,
                      ),
                      controller: cubit.descriptionController,
                      hint: 'Add a message',
                    ),
                    SizedBox(height: heightSpace * 3),
                  ],
                  BlocBuilder<UserBolt11InvoicePromptCubit,
                      UserBolt11InvoicePromptState>(
                    builder: (context, state) {
                      final amount = state.amount;
                      final description = state.description;

                      return SizedBox(
                        width: double.infinity,
                        child: RoundaboutButton(
                          text: amount > 0 ? "Apply" : "Please Enter Amount",
                          onTap: amount > 0
                              ? () {
                                  Navigator.pop(
                                    context,
                                    (amount, description ?? ""),
                                  );
                                }
                              : null,
                        ),
                      );
                    },
                  ),
                  SizedBox(height: heightSpace * 2),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
