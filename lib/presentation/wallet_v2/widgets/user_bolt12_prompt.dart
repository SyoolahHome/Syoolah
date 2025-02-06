import 'package:ditto/buisness_logic/cubit/user_bolt12_offer_prompt_cubit.dart';
import 'package:ditto/presentation/general/text_field.dart';
import 'package:ditto/presentation/general/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBolt12OfferPrompt extends StatelessWidget {
  const UserBolt12OfferPrompt({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserBolt12OfferPromptCubit>(
      create: (context) => UserBolt12OfferPromptCubit(),
      child: Builder(
        builder: (context) {
          final cubit = context.read<UserBolt12OfferPromptCubit>();

          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 20),
              CustomTextField(
                controller: cubit.bolt12InputController,
                hint: "bolt12 offer",
              ),
              SizedBox(height: 20),
              BlocSelector<UserBolt12OfferPromptCubit,
                  UserBolt12OfferPromptState, String?>(
                selector: (state) => state.bolt12Input,
                builder: (context, bolt12Input) {
                  return RoundaboutButton(
                    onTap: bolt12Input != null && bolt12Input.isNotEmpty
                        ? () => Navigator.pop(context, bolt12Input)
                        : null,
                  );
                },
              ),
              SizedBox(height: 20),
            ],
          );
        },
      ),
    );
  }
}
